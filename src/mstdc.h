#ifndef MSTDC_H_
#define MSTDC_H_
#include <stddef.h>
#include <stdint.h>
#include <limits.h>
#include <stdarg.h>

#define MSTDC_VERSION 2023'12'0003
static_assert(MSTDC_VERSION < INT_MAX);

[[noreturn]] void panic(const char *_Nonnull fmt, ...);
[[noreturn]] void panic1(const char *_Nonnull msg);

typedef size_t usize;
typedef ptrdiff_t isize;

typedef uint8_t u8;
typedef int8_t i8;
typedef uint16_t u16;
typedef int16_t i16;
typedef uint32_t u32;
typedef int32_t i32;
typedef uint64_t u64;
typedef int64_t i64;
typedef uintmax_t umax;
typedef intmax_t imax;
typedef float f32;
typedef double f64;

typedef uint8_t ubyte;
typedef int8_t ibyte;

typedef uintptr_t uptr;
typedef intptr_t iptr;

#define U32_MAX UINT32_MAX
#define USIZE_MAX SIZE_MAX
#define UPTR_MAX UINTPTR_MAX

#define span_type_(T, tag, attr) struct tag { usize len; T *attr data; }
#define decl_span_of2_ex(T, tag, attr) span_type_(T, tag, attr)
#define decl_span_of_ex(T, tag) decl_span_of2_ex(T, span__##T, _Nonnull)
#define decl_span_of(T) decl_span_of_ex(T, T##s)
#define decl_opt_span_of(T) decl_span_of2_ex(T, span_opt__##T, _Nullable)
#define span_of_ex(T, tag) struct span__##T
#define opt_span_of_ex(T, tag) struct span_opt__##T
#define span_of(T) span_of_ex(T, T##s)
#define opt_span_of(T) opt_span_of_ex(T, T##s)

typedef decl_opt_span_of(u8) u8s_opt;
typedef decl_span_of(u8) u8s;
#define u8s_c(cstr) ((const u8s){ sizeof(cstr) - 1, (u8*)(cstr) })

typedef decl_span_of(u8s) u8ss;

typedef union {
	struct { float x, y; };
	struct { float r, g; };
	float data[2];
} f32x2;

typedef union {
	struct { f32 x, y, z; };
	struct { f32 r, g, b; };
	f32 data[3];
	f32x2 xy;
} f32x3;

typedef union {
	struct { f32 x, y, z, w; };
	struct { f32 r, g, b, a; };
	f32 data[4];
	f32x3 xyz;
	f32x2 xy;
} f32x4;

typedef struct { uptr fd; } filehandle;
extern filehandle fstderr;
extern filehandle fstdout;
extern filehandle fstdin;

void writeu8(filehandle fout, u8 ch);
void writeu8s(filehandle fout, u8s str);
usize cstrlen(const char *_Nonnull cstr);

static inline void writecstr(filehandle fout, const char *_Nonnull cstr) {
	writeu8s(fout, (u8s){ cstrlen(cstr), (u8*)cstr });
}

void writefmtv(filehandle fout, const char *_Nonnull fmt, va_list va);

[[maybe_unused]] static void writefmt(filehandle fout, const char *_Nonnull fmt, ...) {
	va_list va;
	va_start(va, fmt);
	writefmtv(fout, fmt, va);
	va_end(va);
}

void *_Nonnull memalloc(usize size);
void *_Nonnull memrealloc(void *_Nonnull ptr, usize newsize);
void memdealloc(void *_Nonnull ptr);

void memcopy(void *_Nonnull dst, const void *_Nonnull src, usize size);
static inline usize u8copy(u8 *_Nonnull dst, const u8s src) {
	memcopy(dst, src.data, src.len);
	return src.len;
}

#endif // MSTDC_H_
