#ifndef AOCK_RV64_CORE_H_
#define AOCK_RV64_CORE_H_
#include "mstdc.h"
#include "aock/arch/rv64/mem.h"

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

#define RV_UART0 ((volatile u8*)(uptr)0x10000000LL)

#define RV_SATP_SV39 (8L << 60)
#define RV_MAKE_SATP(PT) (RV_SATP_SV39 | ((u64)(PT) >> 12))

#define RV_DEF_CSR_ACCESS(NAME) \
	static inline void rv_write_##NAME(rv_dword v) { \
		__asm__ volatile ("csrw " #NAME ", %0" : : "r" (v)); \
	} \
	static inline rv_dword rv_read_##NAME() { \
		rv_dword v; \
		__asm__ volatile ("csrr %0, " #NAME : "=r" (v)); \
		return v; \
	}

RV_DEF_CSR_ACCESS(satp);
RV_DEF_CSR_ACCESS(stvec);
RV_DEF_CSR_ACCESS(sstatus);
RV_DEF_CSR_ACCESS(sepc);
RV_DEF_CSR_ACCESS(scause);
RV_DEF_CSR_ACCESS(sip);
RV_DEF_CSR_ACCESS(stval);

#define RV_SSTATUS_SPP (1L << 8) /** previous mode, 1 - supervisor, 0 - user */
#define RV_SSTATUS_SPIE (1L << 5) /** supervisor previous interrupt enable */
#define RV_SSTATUS_UPIE (1L << 4) /** user previous interrupt enable */
#define RV_SSTATUS_SIE (1L << 1) /** supervisor interrupt enable */
#define RV_SSTATUS_UIE (1L << 0) /** user interrupt enable */

static inline void rv_sfence_vma() {
	__asm__ volatile ("sfence.vma zero, zero");
}

#endif // AOCK_RV64_CORE_H_

