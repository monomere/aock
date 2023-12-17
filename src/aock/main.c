#include "mstdc.h"
#include "pm.h"
#include "vm.h"

void kernel_main(uint64_t hartid, uint64_t fdt) {
	LOG("hartid: {u64}, fdt: {p}\n", hartid, fdt);

	extern rv_linksym __kernel_end;
	LOG("kernel end: {p}\n", &__kernel_end);

	aock_pm_init(&__kernel_end);
	rv_pte *vmtab = aock_vm_init();
	LOG("initialized vm\n");

	u8 *page = aock_pm_alloc_page();
	LOG("page: {p}\n", page);

	aock_vm_direct_map(vmtab, page, RV_PAGESIZE, page, RV_PTE_PERM_READ_WRITE_EXEC);
	LOG("mapped page 1\n");
	aock_vm_direct_map(vmtab, page, RV_PAGESIZE, page + RV_PAGESIZE, RV_PTE_PERM_READ_WRITE_EXEC);
	LOG("mapped page 2\n");

	*page = 10;
	LOG("test {u8}", *(page + RV_PAGESIZE));

	PANIC("kernel stoped!");
}


