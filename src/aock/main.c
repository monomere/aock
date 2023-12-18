#include "mstdc.h"
#include "pm.h"
#include "vm.h"

vm_pagetable create_kernel_pagetable() {
	vm_pagetable tab = vm_alloc_pagetable();

	extern rv_linksym __text_start;
	extern rv_linksym __text_end;
	extern rv_linksym __data_start;
	extern rv_linksym __data_end;
	extern rv_linksym __kernel_end;

	vm_map(
		tab,
		(phys_ptr)&__text_start,
		&__text_end - &__text_start,
		(virt_ptr)&__text_start,
		VM_PERMS_READ_EXEC
	);

	vm_map(
		tab,
		(phys_ptr)&__data_start,
		&__data_end - &__data_start,
		(virt_ptr)&__data_start,
		VM_PERMS_READ_WRITE
	);

	vm_map(
		tab,
		(phys_ptr)&__kernel_end,
		VM_PAGESIZE * 16,
		(virt_ptr)&__kernel_end,
		VM_PERMS_READ_WRITE_EXEC
	);

	vm_platform_map(tab);

	return tab;
}

void kernel_main(uint64_t hartid, uint64_t fdt) {
	LOG("hartid: {u64}, fdt: {p}\n", hartid, fdt);

	if (hartid != 0) {
		[[noreturn]] extern void mstdc__panic_();
		mstdc__panic_();
	}

	extern rv_linksym __kernel_end;
	LOG("kernel end: {p}\n", &__kernel_end);

	pm_init(&__kernel_end);
	LOG("initialized pm\n");

	vm_pagetable kptab = create_kernel_pagetable();
	vm_use_pagetable(kptab);
	LOG("initialized vm\n");

	

	PANIC("kernel stopped!");
}


