#ifndef MSTDC_RISCV_H_
#define MSTDC_RISCV_H_
#pragma once // to fix mstdc.h inclusion error in clang(d)
#include "mstdc.h"

typedef u16 rv_hword;
typedef u32 rv_word, rv_sword;
typedef u64 rv_dword;

#define MSTDC_RISCV_VERSION 2023'12'0007
static_assert(MSTDC_RISCV_VERSION < INT_MAX);

static inline rv_dword rv_clz_dword(rv_dword x) {
	rv_dword r;
	__asm__ volatile ("clz %0, %1" : "=r"(r) : "r"(x));
	return r;
}

static inline rv_dword rv_clz_word(rv_word x) {
	rv_dword r;
	__asm__ volatile ("clzw %0, %1" : "=r"(r) : "r"(x));
	return r;
}

static inline rv_dword rv_ctz_dword(rv_dword x) {
	rv_dword r;
	__asm__ volatile ("ctz %0, %1" : "=r"(r) : "r"(x));
	return r;
}

static inline rv_dword rv_ctz_word(rv_word x) {
	rv_dword r;
	__asm__ volatile ("ctzw %0, %1" : "=r"(r) : "r"(x));
	return r;
}

static inline rv_dword rv_cpop_dword(rv_dword x) {
	rv_dword r;
	__asm__ volatile ("cpop %0, %1" : "=r"(r) : "r"(x));
	return r;
}

static inline rv_dword rv_cpop_word(rv_word x) {
	rv_dword r;
	__asm__ volatile ("cpopw %0, %1" : "=r"(r) : "r"(x));
	return r;
}

static inline u64 cpopu64(u64 x) { return rv_cpop_dword(x); }
static inline u64 cpopu32(u64 x) { return rv_cpop_word(x); }
static inline u64 clzu64(u64 x) { return rv_clz_dword(x); }
static inline u64 clzu32(u32 x) { return rv_clz_word(x); }
static inline u64 ctzu64(u64 x) { return rv_ctz_dword(x); }
static inline u64 ctzu32(u32 x) { return rv_ctz_word(x); }

// #ifdef MSTDC_RISCV64
// #define clz(x) _Generic((x), \
// 	i64: clzu64(x), \
// 	u64: clzu64(x), \
// 	i32: clzu32(x), \
// 	u32: clzu32(x) \
// )

#endif // MSTDC_RISCV_H_
