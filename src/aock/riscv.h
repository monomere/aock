#ifndef AOCK_RISCV_H_
#define AOCK_RISCV_H_
#include "mstdc.h"

typedef void* rv_physptr;

typedef struct [[gnu::packed]] {
	u64 valid     : 1;
	u64 perm      : 3;
	u64 user      : 1;
	u64 global    : 1;
	u64 accessed  : 1;
	u64 dirty     : 1;
	u64 rsw       : 2;
	u64 addr      : 44;
	u64           : 7;
	u64 pbmt      : 2;
	u64           : 1;
} rv_pte;

static_assert(sizeof(rv_pte) == 8, "incorrect size for the Sv39 PTE");

typedef enum { //                 XWR
	RV_PTE_PERM_NEXT            = 0b000,
	RV_PTE_PERM_READ_ONLY       = 0b001,
	RV_PTE_PERM_READ_WRITE      = 0b011,
	RV_PTE_PERM_EXEC_ONLY       = 0b100,
	RV_PTE_PERM_READ_EXEC       = 0b101,
	RV_PTE_PERM_READ_WRITE_EXEC = 0b111,
} rv_pte_perm;

#define RV_SATP_SV39 (8L << 60)
#define RV_MAKE_SATP(PT) (RV_SATP_SV39 | ((u64)(PT) >> 12))

static inline void rv_write_satp(rv_dword v) {
	__asm__ volatile ("csrw satp, %0" : : "r" (v));
}

static inline rv_dword rv_read_satp() {
	rv_dword v;
	__asm__ volatile ("csrr %0, satp" : "=r" (v));
	return v;
}

static inline void rv_sfence_vma() {
	__asm__ volatile ("sfence.vma zero, zero");
}

#define RV_PAGESIZE 0x1000
#define RV_PAGE_ROUNDDOWN(A) ((typeof(A))((uptr)(A) & ~(RV_PAGESIZE - 1)))

#endif // AOCK_RISCV_H_
