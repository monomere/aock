#include "mstdc.h"
#include "pm.h"

void kernel_main(uint64_t hartid, uint64_t fdt) {
	LOG("hartid: {u64}, fdt: {p}\n", hartid, fdt);

	rv_physptr pages = aock_alloc_pages(8);
	LOG("8 pages at {p}\n", pages);

	PANIC("oh no!");
}


