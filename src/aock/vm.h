#ifndef AOCK_VM_H_
#define AOCK_VM_H_
#include "mstdc.h"
#include "aock/core.h"

typedef enum {
	VM_PERMS_READ_ONLY,
	VM_PERMS_READ_WRITE,
	VM_PERMS_EXEC_ONLY,
	VM_PERMS_READ_EXEC,
	VM_PERMS_READ_WRITE_EXEC,
} vm_perms;

typedef void *vm_pagetable;

/** TODO: move to aock/arch.h */
#define VM_PAGESIZE 4096

/** allocate new pagetable with the pm allocator. */
vm_pagetable vm_alloc_pagetable();

/** set the current used pagetable. */
void vm_use_pagetable(vm_pagetable tab);

/** map `size/0x1000 pages` from `pa` to `va` in `tab` with `perms`.
  * `pa` and `va` have to be aligned to `VM_PAGESIZE`,
	* `size` has to be a multiple of `VM_PAGESIZE`. */
void vm_map(
	vm_pagetable tab,
	phys_ptr pa,
	usize size,
	virt_ptr va,
	vm_perms perms
);

/** unmap `size/0x1000 pages` starting with `va` in `tab`.
  * `va` have to be aligned to `VM_PAGESIZE`,
	* `size` has to be a multiple of `VM_PAGESIZE`. */
void vm_unmap(
	vm_pagetable tab,
	usize size,
	virt_ptr va
);

/** direct map platform-specific pages. */
void vm_platform_map(vm_pagetable tab);

#endif // AOCK_VM_H_
