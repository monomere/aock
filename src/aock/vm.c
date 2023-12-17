#include "aock/vm.h"
#include "aock/pm.h"
#include "aock/riscv.h"

// map the kernel address space.
// `&__kernel_start` ~ `&__kernel_end`
static rv_pte *map_kernel_() {
	rv_pte *tab = aock_pm_alloc_page();
	inline_memzero(tab, RV_PAGESIZE);

	extern rv_linksym __kernel_start;
	extern rv_linksym __kernel_end;

	aock_vm_direct_map(
		tab,
		&__kernel_start,
		&__kernel_end - &__kernel_start,
		&__kernel_start,
		RV_PTE_PERM_READ_WRITE_EXEC
	);

	return tab;
}

rv_pte *aock_vm_init() {
	return map_kernel_();
}

/** extracts the 9-bit page table index (for specified level) from an address. */
#define PIDX(level, va) (((u64)(va) >> (12 + 9 * (level))) & 0x1FF)

static rv_pte *walk_(rv_pte *tab, void *va, int alloc) {
	for (int level = 2; level > 0; --level) {
		rv_pte *pte = &tab[PIDX(level, va)];
		if (pte->valid) tab = (rv_physptr)(uptr)pte->addr;
		else {
			if (!alloc) return nullptr;
			tab = aock_pm_alloc_page();
			inline_memzero(tab, RV_PAGESIZE);
			pte->valid = true;
			pte->addr = (uptr)tab;
		}
	}
	return &tab[PIDX(0, va)];
}

void aock_vm_direct_map(
	rv_pte *tab,
	rv_physptr pa,
	usize size,
	void *va,
	rv_pte_perm perm
) {
	if (size == 0) PANIC("cannot map 0 pages");
	rv_physptr cur = RV_PAGE_ROUNDDOWN(va);
	rv_physptr end = RV_PAGE_ROUNDDOWN(va + size - 1);
	LOG("direct map {usz} bytes from {p} to {p}\n", size, pa, va);

	do {
		rv_pte *pte = walk_(tab, cur, 1);
		if (pte->valid) PANIC("page [{p} -> {p}] already mapped", pa, cur);
		pte->addr = (uptr)pa;
		pte->perm = perm;
		pte->valid = true;
		cur += RV_PAGESIZE;
		pa += RV_PAGESIZE;
	} while (cur < end);
}
