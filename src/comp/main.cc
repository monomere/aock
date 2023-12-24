#include <string_view>
#include <concepts>
#include <memory>
#include <cstdio>
#include "driver.hh"

struct source_pos {
	std::ptrdiff_t offset;
	source_pos operator +(std::ptrdiff_t d) const { return { offset + d }; }
	source_pos operator -(std::ptrdiff_t d) const { return { offset - d }; }
};

struct source_span { source_pos a, b; };

enum class node_type { id = 1, intlit, boollit, binop };
namespace binop_type {
	enum t {
		add = 1, sub, mul, div, mod,
		shl, shr, ashr,
		bit_or, bit_and, bit_xor,
		bool_or, bool_and, bool_xor,
		eq, ne, gt, lt, ge, le
	};

	int precedence(t b) {
		switch (b) {
		case add: case sub: return 5;
		case mul: case div: case mod: return 6;
		case shl: case shr: case ashr: return 8;
		case bit_or: case bit_and: case bit_xor: return 7;
		case bool_or: case bool_and: case bool_xor: return 2;
		case eq: case ne: return 3;
		case gt: case lt: case ge: case le: return 4;
		}
	}

	const char *to_str(t b) {
		switch (b) {
#define CASE(C, E) case C: return E
		CASE(add, "+"); CASE(sub, "-"); CASE(mul, "*"); CASE(div, "/"); CASE(mod, "%");
		CASE(shl, "<<"); CASE(shr, ">>"); CASE(ashr, "<<<");
		CASE(bit_or, "|"); CASE(bit_and, "&"); CASE(bit_xor, "^");
		CASE(bool_or, "||"); CASE(bool_and, "&&"); CASE(bool_xor, "^^");
		CASE(eq, "=="); CASE(ne, "!=");
		CASE(gt, ">"); CASE(lt, "<");
		CASE(ge, ">="); CASE(le, "<=");
#undef CASE
		}
	}
}

struct node { source_span span; };
template<node_type default_type>
struct node_base : node { source_span span; node_type type = default_type; };
struct id_node : node_base<node_type::id> { std::string_view name; };
struct intlit_node : node_base<node_type::intlit> { std::size_t value; };
struct boollit_node : node_base<node_type::boollit> { bool value; };
struct binop_node : node_base<node_type::binop> { std::unique_ptr<node> lhs, rhs; binop_type::t op; };

bool is_space(char c) { return c == ' ' || c == '\n' || c == '\r' || c == '\t'; }
bool is_digit(char c) { return c >= '0' && c <= '9'; }

const char *skip_ws(const char *inp) {
	while (is_space(*inp)) ++inp;
	return inp;
}

struct parsectx {
	const char *base;
	source_pos pos(const char *a) const { return { a - base }; }
	source_span span(const char *a, const char *b) const { return { pos(a), pos(b) }; }
};


template<typename ...Args>
void format(driver::filehandle fout, const char *fmt, Args &&...args);

template<typename T>
struct formatter {
	void format(driver::filehandle fout, const T &o) const = delete;
};

template<>
struct formatter<char> {
	void format(driver::filehandle fout, char val) const {
		fout.write(val);
	}
};

template<typename T> requires std::integral<std::decay_t<T>>
struct formatter<T> {
	using U = std::decay_t<T>;
	void format(driver::filehandle fout, U val) const {
		// U orig = val;
		int base = 10;
		if (base < 2 || base > 36) { return; }
		char res[std::numeric_limits<T>::digits + 1] = {0};
		char *ptr = res;
		U val2;
		do {
			val2 = val;
			val = val / base;
			*ptr++ = "zyxwvutsrqponmlkjihgfedcba9876543210123456789abcdefghijklmnopqrstuvwxyz"
				[35 + (val2 - val * base)];
		} while (val);
		if (val2 < 0) *ptr++ = '-';
		std::size_t len = ptr-- - res;
		for (char *ptr1 = res; ptr1 < ptr; ) {
			char tmp = *ptr;
			*ptr-- = *ptr1;
			*ptr1++ = tmp;
		}
		// std::fprintf(stderr, "len = %zu, res = '%s', val = %d\n", len, res, (int)orig);
		fout.write(std::string_view(res, len));
	}
};

template<std::convertible_to<std::string_view> T>
struct formatter<T> {
	void format(driver::filehandle fout, const T &val) const {
		fout.write(std::string_view(val));
	}
};

namespace detail {
	template<typename Args, typename ArgFmts, std::size_t N = 0>
	void format_ith_(driver::filehandle fout, const Args &args, const ArgFmts &fmts, std::size_t idx) {
		if constexpr (N >= std::tuple_size_v<Args>) {
			return;
		} else if (N == idx) {
			std::get<N>(fmts).format(fout, std::get<N>(args));
		} else {
			format_ith_<Args, ArgFmts, N + 1>(fout, args, fmts, idx);
		}
	}
}

template<typename ...Args>
void format(driver::filehandle fout, const char *fmt, Args &&...args) {
	std::tuple<Args...> argt = { args... };
	std::tuple<formatter<Args>...> fmtt;
	std::size_t idx = 0;
	std::size_t off = 0;
	const char *last = fmt;
	while (*fmt) {
		if (*fmt == '{') {
			if (*(fmt + 1) == '{') { fmt += 2; continue; }
			fout.write(std::string_view(last, fmt - last));
			++fmt; ++off;
			if (is_digit(*fmt)) {
				idx = 0;
				while (is_digit(*fmt)) {
					idx = idx * 10 + std::size_t(idx - '0');
					++fmt; ++off;
				}
			}
			if (*fmt != '}') format(driver::fstderr, "format: expected '}' at offset {}.", off);
			++fmt; ++off;
			detail::format_ith_(fout, argt, fmtt, idx);
			++idx;
			last = fmt;
		} else ++fmt;
	}
	fout.write(std::string_view(last, fmt - last));
}


template<typename T>
struct generic_parsed { T res; const char *inp; };

using parsed = generic_parsed<std::unique_ptr<node>>;

parsed parse_atom(parsectx &ctx, const char *inp) {
	const char *start = skip_ws(inp);

	if (is_digit(*inp)) {
		std::size_t r = 0;
		while (is_digit(*inp)) {
			r = r * 10 + std::size_t(*inp - '0');
			++inp;
		}
		return { std::unique_ptr<node>(new intlit_node { { .span = ctx.span(start, inp) }, r }), inp };
	}

	format(driver::fstderr, "expected atom at {}!\n", ctx.pos(inp).offset);
	driver::fail("parse error");
}

parsed parse_suffix(parsectx &ctx, const char *inp) {
	parsed x = parse_atom(ctx, inp);
	inp = x.inp;
	return x;
}

parsed parse_prefix(parsectx &ctx, const char *inp) {
	parsed x = parse_atom(ctx, inp);
	inp = x.inp;
	return x;
}

generic_parsed<binop_type::t> parse_binop([[maybe_unused]] parsectx &ctx, const char *inp) {
	namespace B = binop_type;
	if (*inp == '+') return { B::add, inp + 1 };
	if (*inp == '-') return { B::sub, inp + 1 };
	if (*inp == '*') return { B::mul, inp + 1 };
	if (*inp == '/') return { B::div, inp + 1 };
	if (*inp == '%') return { B::mod, inp + 1 };
	return { B::t(0), inp };
}

parsed parse_infix(parsectx &ctx, const char *inp, int prec_lim = 0) {
	parsed l = parse_prefix(ctx, inp);
	inp = l.inp;
	const char *start = inp;
	for (generic_parsed<binop_type::t> o; (o = parse_binop(ctx, start = inp = skip_ws(inp))).res != 0;) {
		if (binop_type::precedence(o.res) < prec_lim) return l;
		inp = o.inp;
		parsed r = parse_infix(ctx, inp = skip_ws(inp));
		inp = r.inp;
		l = {
			std::unique_ptr<node>(new binop_node {
				{ .span = ctx.span(start, inp) },
				std::move(l.res), std::move(r.res), o.res
			}),
			inp
		};
	}
	return l;
}

parsed parse_expr(parsectx &ctx, const char *inp) {
	parsed x = parse_infix(ctx, inp);
	inp = x.inp;
	return x;
}

parsed parse(parsectx &ctx, const char *inp) {
	parsed x = parse_expr(ctx, inp);
	inp = x.inp;
	return x;
}

void dump_node(driver::filehandle fout, const node &node, int indent = 0) {
	const auto &n = *(const node_base<node_type(0)>*)&node;

	for (int i = indent * 2; i --> 0; ) fout.write(' ');

	switch (n.type) {
		case node_type::id: format(fout, "id \"{}\"\n", ((id_node&)n).name); break;
		case node_type::intlit: format(fout, "int {}\n", ((intlit_node&)n).value); break;
		case node_type::boollit: format(fout, "int {}\n", ((boollit_node&)n).value ? "true" : "false"); break;
		case node_type::binop: {
			binop_node &d = (binop_node&)n;
			format(fout, "binop '{}':\n", binop_type::to_str(d.op));
			dump_node(fout, *d.lhs, indent + 1);
			dump_node(fout, *d.rhs, indent + 1);
		} break;
	}
}

int main() {
	parsectx pctx = { "1+2" };
	auto [node, rest] = parse(pctx, pctx.base);
	dump_node(driver::fstderr, *node);
	return 0;
}

namespace driver {
	void filehandle::write(char c) {
		std::fputc(c, (FILE *)(void *)id);
	}

	void filehandle::write(std::string_view s) {
		std::fwrite(s.data(), 1, s.size(), (FILE *)(void *)id);
	}

	void fail(const char *why) {
		std::fprintf(stderr, "\033[31mfailed: %s\033[m\n", why);
		std::exit(1);
	}

	filehandle fstderr = { (std::intptr_t)(void *)stderr };
	filehandle fstdout = { (std::intptr_t)(void *)stdout };
}
