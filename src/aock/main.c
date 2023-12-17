#include "mstdc.h"
#include "pm.h"

void kernel_main(uint64_t hartid, uint64_t fdt) {
	LOG("hartid: {u64}, fdt: {p}\n", hartid, fdt);

	extern rv_linksym __kernel_end;
	LOG("kernel end: {p}\n", &__kernel_end);

	aock_pm_init(&__kernel_end);

	PANIC("kernel stoped!");
}


