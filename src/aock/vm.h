#ifndef AOCK_VM_H_
#define AOCK_VM_H_
#include "mstdc.h"
#include "aock/riscv.h"

rv_pte *aock_vm_init();
void aock_vm_direct_map(
	rv_pte *tab,
	rv_physptr pa,
	usize size,
	void *va,
	rv_pte_perm perm
);

#endif // AOCK_VM_H_
