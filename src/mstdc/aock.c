#include "mstdc.h"

filehandle fstderr = { .fd = 2 };
filehandle fstdout = { .fd = 1 };
filehandle fstdin = { .fd = 0 };

static volatile u8 *uart = (u8*)0x10000000;

void writeu8([[maybe_unused]] filehandle fout, u8 ch) {
	*uart = ch;
}

void writeu8s([[maybe_unused]] filehandle fout, u8s str) {
	while (str.len --> 0) *uart = *(str.data++);
}

[[noreturn]] void mstdc__panic_();

__asm__ (
	".global mstdc__panic_\n"
	"mstdc__panic_:\n"
	"1:"
	"  wfi\n"
	"  j 1b\n"
);

// void *memalloc(usize size) {
// 	extern void *mstdc__memalloc_(usize size);
// 	return mstdc__memalloc_(size);
// }

// void *memrealloc(void *ptr, usize size) {
// 	extern void *mstdc__memrealloc_(void *ptr, usize size);
// 	return mstdc__memrealloc_(ptr, size);
// }

// void memdealloc(void *ptr) {
// 	extern void mstdc__memdealloc_(void *ptr);
// 	mstdc__memdealloc_(ptr);
// }
