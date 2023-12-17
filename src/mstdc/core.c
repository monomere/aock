#include "mstdc.h"

usize cstrlen(const char *cstr) {
	usize l = 0;
	while (cstr[l++]) continue;
	return l - 1;
}

[[noreturn]] void panic1(const char *msg) {
	writecstr(fstderr, "\n\x1b[1;31m[panic]:\x1b[m ");
	writeu8s(fstderr, (u8s){ cstrlen(msg), (u8*)msg });
	writeu8(fstderr, '\n');

	[[noreturn]] extern void mstdc__panic_();
	mstdc__panic_();
}

[[noreturn]] void panic(const char *fmt, ...) {
	(void)fmt;
	writecstr(fstderr, "\n\x1b[1;31m[panic]:\x1b[m ");
	va_list va;
	va_start(va, fmt);
	writefmtv(fstderr, fmt, va);
	va_end(va);
	writeu8(fstderr, '\n');

	[[noreturn]] extern void mstdc__panic_();
	mstdc__panic_();
}

#define write_iN_to_buf_fn_(T) \
	[[maybe_unused]] static usize write_##T##_to_buf_( \
		T val, \
		u8 *res, \
		u8 base \
	) { \
		if (base < 2 || base > 36) { *res = '\0'; } \
		u8 *ptr = res; \
		T val2; \
		do { \
			val2 = val; \
			val /= base; \
			*ptr++ = "zyxwvutsrqponmlkjihgfedcba9876543210123456789abcdefghijklmnopqrstuvwxyz" \
				[35 + (val2 - val * base)]; \
		} while (val); \
		if (val2 < 0) *ptr++ = '-'; \
		usize len = ptr-- - res; \
		for (u8 *ptr1 = res; ptr1 < ptr; ) { \
			u8 tmp = *ptr; \
			*ptr-- = *ptr1; \
			*ptr1++ = tmp; \
		} \
		return len; \
	}

#define write_uN_to_buf_fn_(T) \
	[[maybe_unused]] static usize write_##T##_to_buf_( \
		T val, \
		u8 *res, \
		u8 base \
	) { \
		if (base < 2 || base > 36) { *res = '\0'; } \
		u8 *ptr = res; \
		T val2; \
		do { \
			val2 = val; \
			val /= base; \
			*ptr++ = "0123456789abcdefghijklmnopqrstuvwxyz" \
				[(val2 - val * base)]; \
		} while (val); \
		usize len = ptr-- - res; \
		for (u8 *ptr1 = res; ptr1 < ptr; ) { \
			u8 tmp = *ptr; \
			*ptr-- = *ptr1; \
			*ptr1++ = tmp; \
		} \
		return len; \
	}

write_iN_to_buf_fn_(isize)
write_iN_to_buf_fn_(iptr)
write_iN_to_buf_fn_(i64)
write_iN_to_buf_fn_(i32)
write_iN_to_buf_fn_(i16)
write_iN_to_buf_fn_(i8)
write_uN_to_buf_fn_(usize)
write_uN_to_buf_fn_(uptr)
write_uN_to_buf_fn_(u64)
write_uN_to_buf_fn_(u32)
write_uN_to_buf_fn_(u16)
write_uN_to_buf_fn_(u8)

static const char u8_escs_[] =
	"\nn\tt\\\\\rr\'\'\"\"\00\ee\bb\aa\vv\ff";

static usize u8_nesc_ = sizeof(u8_escs_) / sizeof(u8_escs_[0]);

static usize len_of_escaped_u8(u8 c) {
	if (c >= 32 && c < 127) return 1;
	for (usize i = 0; i < u8_nesc_; i += 2) {
		if (c == u8_escs_[i]) return 2; // \c
	}
	return 4; // \xHH
}

static usize write_escaped_u8_to_buf_(u8 *res, u8 c) {
	if (c >= 32 && c < 127) {
		*res = c;
		return 1;
	}

	for (usize i = 0; i < u8_nesc_; i += 2) {
		if (c == u8_escs_[i]) {
			*res++ = '\\';
			*res = u8_escs_[i + 1];
			return 2;
		}
	}

	*res++ = '\\';
	*res++ = 'x';
	write_u8_to_buf_(c, res, 16);
	return 4; // \xHH
}

static usize len_of_escaped_u8s_(u8s s) {
	usize len = 0;
	for (usize i = 0; i < s.len; ++i) {
		len += len_of_escaped_u8(s.data[i]);
	}
	return len;
}

static usize write_escaped_u8s_to_buf_(u8 *res, u8s s) {
	usize len = 0;
	for (usize i = 0; i < s.len; ++i) {
		len += write_escaped_u8_to_buf_(res + len, s.data[i]);
	}
	return len;
}

typedef enum {
	ALIGN_LEFT = 0,
	ALIGN_RIGHT = 1,
	ALIGN_MIDDLE = 2,
} alignmode;

typedef enum : u8 {
	STRTYPE_NORMAL = 0,
	STRTYPE_ESCAPED,
} strtype;

typedef struct {
	u8 spec;
	u8 fill;
	alignmode align;
	usize width;
	union {
		u8 intbase;
		strtype strtype;
	};
} fmtinfo;

static void write_with_fmt_(
	filehandle fout,
	fmtinfo *fmt,
	u8s str
) {
	usize width = fmt->width;
	u8 fillbuf[width];
	usize filllen = 0;
	while (width > str.len) {
		fillbuf[filllen] = fmt->fill;
		--width;
		++filllen;
	}

	if (fmt->align == ALIGN_RIGHT)
		writeu8s(fout, (u8s){ filllen, fillbuf });
	
	writeu8s(fout, str);
	
	if (fmt->align == ALIGN_LEFT)
		writeu8s(fout, (u8s){ filllen, fillbuf });
}

enum : u8 {
	SPEC__BEGIN_ = 129,
	SPEC_P, SPEC_CHAR,
	SPEC_U8S, SPEC_CSTR,
	SPEC_UPTR, SPEC_IPTR,
	SPEC_USZ, SPEC_ISZ,
	SPEC_U64, SPEC_I64,
	SPEC_U32, SPEC_I32,
	SPEC_U16, SPEC_I16,
	SPEC_U8, SPEC_I8,
};

void writefmtv(
	filehandle fout,
	const char *fmtstr,
	va_list va
) {
	const char *cur = fmtstr;
	const char *last = cur;
	while (*cur) {
		if (*cur == '{') {
			if (*(cur + 1) == '{') {
				writeu8s(fout, (u8s){ cur - last, (u8*)last });
				cur += 1;
				last = cur++;
				continue;
			}

			writeu8s(fout, (u8s){ cur - last, (u8*)last });
			fmtinfo fmt = {};

			u8 ch = *++cur;
			switch (ch) {
				// pointers.
				case 'p': fmt.spec = SPEC_P; break;

				// integers.
				// <base><type> e.g. 'usz', 'x32', 'optr'
				case 'i':
				case 'u':
				case 'x':
				case 'b':
				case 'o': {
					int sign = 0;
					fmt.spec = SPEC_U32; // default
					switch (ch) {
						case 'i': fmt.spec = SPEC_I32; sign = 1;
						case 'u': fmt.intbase = 10; break;
						case 'x': fmt.intbase = 16; break;
						case 'b': fmt.intbase = 2; break;
						case 'o': fmt.intbase = 8; break;
						default: __builtin_unreachable();
					}

	#define CHECK2(A, B, U) \
		if (*(cur + 1) == A && *(cur + 2) == B) { \
			cur += 2; \
			fmt.spec = U + sign; \
		}
					// [uixob](sz|64|32|16)
					CHECK2('s', 'z', SPEC_USZ);
					CHECK2('6', '4', SPEC_U64);
					CHECK2('3', '2', SPEC_U32);
					CHECK2('1', '6', SPEC_U16);
					
					// [uixob]8
					if (*(cur + 1) == '8') {
						cur += 1;
						fmt.spec = SPEC_U8 + sign;
					}
					
					// [uixob]ptr
					if (
						*(cur + 1) == 'p' &&
						*(cur + 2) == 't' &&
						*(cur + 3) == 'r'
					) {
						cur += 3;
						fmt.spec = SPEC_UPTR + sign;
					}
				} break;

				// strings.
				case 'S': fmt.strtype = STRTYPE_ESCAPED;
				case 's': fmt.spec = SPEC_U8S; break;
				
				// c strings.
				case 'Z': fmt.strtype = STRTYPE_ESCAPED;
				case 'z': fmt.spec = SPEC_CSTR; break;

				// chars.
				case 'C': fmt.strtype = STRTYPE_ESCAPED;
				case 'c': fmt.spec = SPEC_CHAR; break;
				
				default: panic("unknown format specifier: '{C}'", ch);
			}

			if (*++cur == ':') {
				fmt.fill = *++cur;
				switch (*++cur) {
					case '<': fmt.align = ALIGN_LEFT; break;
					case '^': fmt.align = ALIGN_MIDDLE; break;
					default:
					case '>': fmt.align = ALIGN_RIGHT; break;
				}

				fmt.width = 0;
				
				if (*cur == '$') {
					fmt.width = U32_MAX;
				} else while (*cur >= '0' && *cur <= '9') {
					fmt.width = fmt.width * 10 + *cur - '0';
					++cur;
				}
			}

			// fprintf(stderr, "fmtinfo{.fill='%c',.align=%d,.width=%zu,.spec='%c'}\n",
			// 	fmt.fill, fmt.align, fmt.width, fmt.spec);
			
			if (*cur != '}') panic("expected '}}'");
			++cur;

#define GET_WIDTH() (fmt.width = \
	(fmt.width == U32_MAX ? va_arg(va, usize) : fmt.width))
			
			switch (fmt.spec) {
				case SPEC_CSTR:
				case SPEC_U8S:
				case SPEC_CHAR: {
					u8s src;
					u8 ch; // for SPEC_CHAR to store the character in.

					switch (fmt.spec) {
						case SPEC_CSTR: {
							const char *s = va_arg(va, const char *);
							src = (u8s){ cstrlen(s), (u8*)s };
						} break;
						case SPEC_U8S: {
							src = va_arg(va, u8s);
						} break;
						case SPEC_CHAR: {
							ch = va_arg(va, int);
							src = (u8s){ 1, &ch };
						} break;
						default: __builtin_unreachable();
					}

					GET_WIDTH();
					
					switch (fmt.strtype) {
						case STRTYPE_ESCAPED: {
							usize len = len_of_escaped_u8s_(src);
							u8 buf[len];
							write_escaped_u8s_to_buf_(buf, src);
							write_with_fmt_(fout, &fmt, (u8s){ len, buf });
						} break;
						case STRTYPE_NORMAL: {
							write_with_fmt_(fout, &fmt, src);
						} break;
						default: panic("strtype not implemented: {i}", fmt.strtype);
					}
				} break;
				case SPEC_USZ: case SPEC_ISZ: case SPEC_UPTR: case SPEC_IPTR:
				case SPEC_U64: case SPEC_U32: case SPEC_U16: case SPEC_U8:
				case SPEC_I64: case SPEC_I32: case SPEC_I16: case SPEC_I8:
				case SPEC_P: {
					static u8 buf[256];
					usize len = 0;

					switch (fmt.spec) {
#define CASE(S, T) case S: len = write_##T##_to_buf_(va_arg(va, T), buf, fmt.intbase); break
						CASE(SPEC_UPTR, uptr); CASE(SPEC_IPTR, iptr);
						CASE(SPEC_USZ, usize); CASE(SPEC_ISZ, isize);
						CASE(SPEC_U32, u32); CASE(SPEC_I32, i32);
						CASE(SPEC_U64, u64); CASE(SPEC_I64, i64);
						CASE(SPEC_U16, u32); CASE(SPEC_I16, i32);
						CASE(SPEC_U8, u32); CASE(SPEC_I8, i32);
#undef CASE
						case SPEC_P: {
							writeu8s(fout, u8s_c("0x"));
							len = write_uptr_to_buf_((uptr)va_arg(va, uptr), buf, 16);
							fmt.fill = '0';
							fmt.align = ALIGN_RIGHT;
							fmt.width = sizeof(uptr) * 2;
						} break;
						default: __builtin_unreachable();
					}
					GET_WIDTH();
					write_with_fmt_(fout, &fmt, (u8s){ len, buf });
				} break;
				default: panic("format specifier not implemented: {i}", fmt.spec);
			}

			last = cur;

		} else if (*cur == '}') {
			if (*(cur + 1) == '}') {
				writeu8s(fout, (u8s){ cur - last, (u8*)last });
				cur += 1;
				last = cur++;
				continue;
			}
			panic("extraneous '}}'\n\"{Z}\"\n{*x}^", fmtstr, cur - fmtstr);
		} else {
			++cur;
		}
	}
	
	writeu8s(fout, (u8s){ cur - last, (u8*)last });
}

