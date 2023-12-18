#include "mstdc.h"
#include "aock/arch/rv64/core.h"

filehandle fstderr = { .fd = 2 };
filehandle fstdout = { .fd = 1 };
filehandle fstdin = { .fd = 0 };

void writeu8([[maybe_unused]] filehandle fout, u8 ch) {
	*RV_UART0 = ch;
}

void writeu8s([[maybe_unused]] filehandle fout, u8s str) {
	while (str.len --> 0) {
		*RV_UART0 = *(str.data++);
	}
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
