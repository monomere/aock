#include "mstdc.h"

void kernel_main(uint64_t hartid, uint64_t fdt) {
	writefmt(fstdout, "hartid: {u64}, fdt: {p}\n", hartid, fdt);
	panic("oh no!");
}


