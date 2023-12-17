#include "aock/vm.h"
#include "aock/pm.h"
#include "aock/riscv.h"

// map the kernel address space.
// `&__kernel_start` ~ `&__kernel_end`
static rv_pte *map_kernel_() {
	rv_pte *tab = aock_pm_alloc_page();
	inline_memzero(tab, RV_PAGESIZE);

	extern rv_linksym __text_start;
	extern rv_linksym __text_end;
	extern rv_linksym __data_start;
	extern rv_linksym __data_end;
	extern rv_linksym __kernel_end;

	aock_vm_direct_map(
		tab,
		&__text_start,
		&__text_end - &__text_start,
		&__text_start,
		RV_PTE_PERM_READ_EXEC
	);

	aock_vm_direct_map(
		tab,
		&__data_start,
		&__data_end - &__data_start,
		&__data_start,
		RV_PTE_PERM_READ_WRITE
	);

	aock_vm_direct_map(
		tab,
		&__kernel_end,
		RV_PAGESIZE * 16,
		&__kernel_end,
		RV_PTE_PERM_READ_WRITE
	);

	return tab;
}

rv_pte *aock_vm_init() {
	rv_pte *tab = map_kernel_();
	rv_sfence_vma();
	rv_write_satp(RV_MAKE_SATP(tab));
	rv_sfence_vma();
	return tab;
}

/** extracts the 9-bit page table index (for specified level) from an address. */
#define PIDX(level, va) (((u64)(va) >> (12 + 9 * (level))) & 0x1FF)

static rv_pte *walk_(rv_pte *tab, void *va, int alloc) {
	for (int level = 2; level > 0; --level) {
		rv_pte *pte = &tab[PIDX(level, va)];
		if (pte->valid) tab = (rv_physptr)((uptr)pte->addr << 12);
		else {
			if (!alloc) return nullptr;
			tab = aock_pm_alloc_page();
			inline_memzero(tab, RV_PAGESIZE);
			pte->valid = true;
			pte->addr = (uptr)tab >> 12;
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
	LOG("direct map {usz} bytes from pa:{p} to va:{p}\n", size, pa, va);

	int i = 0;
	do {

		if (size == 65536)
			LOG("mapping #{i} {p} to {p}\n", i, pa, va);
		i++;
		rv_pte *pte = walk_(tab, cur, 1);
		if (pte->valid) PANIC("page from pa:{p} to va:{p} already mapped", pa, cur);
		pte->addr = (uptr)pa >> 12;
		pte->perm = perm;
		pte->valid = true;
		cur += RV_PAGESIZE;
		pa += RV_PAGESIZE;
	} while (cur < end);
}
