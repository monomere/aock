#include "aock/vm.h"
#include "aock/pm.h"
#include "aock/arch/rv64/core.h"

void vm_platform_map(vm_pagetable tab) {
	vm_map(
		tab,
		(phys_ptr)RV_UART0,
		VM_PAGESIZE,
		(virt_ptr)RV_UART0,
		VM_PERMS_READ_WRITE
	);
}

void vm_use_pagetable(vm_pagetable tab) {
	LOG("setting satp... ");
	rv_sfence_vma();
	rv_write_satp(RV_MAKE_SATP(tab));
	rv_sfence_vma();
	writefmt(fstderr, "done\n");
}

vm_pagetable vm_alloc_pagetable() {
	vm_pagetable tab = pm_alloc_page();
	inline_memzero(tab, RV_PAGESIZE);
	return tab;
}

/** extracts the 9-bit page table index (for specified level) from an address. */
#define PIDX(LVL, VA) (((u64)(VA) >> (12 + 9 * (LVL))) & 0x1ff)

static rv_pte *walk_(rv_pte *tab, void *va, bool alloc) {
	if (va >= RV_MAXVA) PANIC("virtual address too big");

	for (int level = 2; level >= 1; --level) {
		rv_pte *pte = &tab[PIDX(level, va)];
		if (pte->valid) { // descend
			tab = (rv_physptr)(pte->addr << 12);
		} else { // create table and descend into it
			if (!alloc) return nullptr;
			tab = (rv_pte *)vm_alloc_pagetable();
			pte->valid = true;
			pte->addr = (uptr)tab >> 12;
		}
	}

	return &tab[PIDX(0, va)];
}

static const char *vm_perms_to_str(vm_perms perms) {
	switch (perms) {
		case VM_PERMS_READ_ONLY:       return "R··";
		case VM_PERMS_READ_WRITE:      return "RW·";
		case VM_PERMS_EXEC_ONLY:       return "··X";
		case VM_PERMS_READ_EXEC:       return "R·X";
		case VM_PERMS_READ_WRITE_EXEC: return "RWX";
	}
}

static rv_pte_perm vm_perms_to_rv_pte_perm(vm_perms perms) {
	switch (perms) {
		case VM_PERMS_READ_ONLY: return RV_PTE_PERM_READ_ONLY;
		case VM_PERMS_READ_WRITE: return RV_PTE_PERM_READ_WRITE;
		case VM_PERMS_EXEC_ONLY: return RV_PTE_PERM_EXEC_ONLY;
		case VM_PERMS_READ_EXEC: return RV_PTE_PERM_READ_EXEC;
		case VM_PERMS_READ_WRITE_EXEC: return RV_PTE_PERM_READ_WRITE_EXEC;
	}
}

void vm_map(
	vm_pagetable tab_,
	phys_ptr pa,
	usize size,
	virt_ptr va,
	vm_perms perm
) {
	rv_pte *tab = tab_;

	if (((uptr)pa & (RV_PAGESIZE - 1)) != 0)
		PANIC("p:{p} is not aligned to 0x{x}", pa, RV_PAGESIZE);

	if (((uptr)va & (RV_PAGESIZE - 1)) != 0)
		PANIC("v:{p} is not aligned to 0x{x}", va, RV_PAGESIZE);

	if ((size & (RV_PAGESIZE - 1)) != 0)
		PANIC("size {usz} is not a multiple of 0x{x}", size, RV_PAGESIZE);

	// // if the address is aligned to 2MiB and size is bigger than 2MiB
	// while (((uptr)pa & (RV_MEGAPAGESIZE - 1)) == 0 && size >= RV_MEGAPAGESIZE) {
	// 	size -= RV_MEGAPAGESIZE;
	// 	pa += RV_MEGAPAGESIZE;
	// }
	// // map the rest with 4KiB pages

	LOG(
		"map {p}~{p} -> {p}~{p} with {z}\n",
		pa, pa + size,
		va, va + size,
		vm_perms_to_str(perm)
	);

	rv_physptr end = pa + size;
	while (pa < end) {
		// LOG("{p} -> {p}\n", pa, va);
		rv_pte *pte = walk_(tab, va, true);
		if (pte == nullptr) PANIC("bad page");
		pte->valid = true;
		pte->perm = vm_perms_to_rv_pte_perm(perm);
		pte->addr = (uptr)pa >> 12;
		va += RV_PAGESIZE;
		pa += RV_PAGESIZE;
	}
}

void vm_unmap(
	vm_pagetable tab_,
	usize size,
	virt_ptr va
) {
	rv_pte *tab = tab_;

	if (((uptr)va & (RV_PAGESIZE - 1)) != 0)
		PANIC("v:{p} is not aligned to 0x{x}", va, RV_PAGESIZE);

	if ((size & (RV_PAGESIZE - 1)) != 0)
		PANIC("size {usz} is not a multiple of 0x{x}", size, RV_PAGESIZE);

	LOG("unmap {p}~{p}\n", va, va + size);

	rv_physptr end = va + size;
	while (va < end) {
		rv_pte *pte = walk_(tab, va, true);
		if (pte == nullptr) PANIC("bad page");
		pte->valid = false;
		va += RV_PAGESIZE;
	}
}

