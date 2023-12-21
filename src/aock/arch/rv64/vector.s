#include "aock/arch/rv64/mem.h"

.section .trampoline

/** kernel trap vector */
.global rv_kernel_vec
.align 4
rv_kernel_vec:
  addi sp, sp, -256

	sd ra, 0(sp)
	sd sp, 8(sp)
	sd gp, 16(sp)
	sd tp, 24(sp)
	sd t0, 32(sp)
	sd t1, 40(sp)
	sd t2, 48(sp)
	sd s0, 56(sp)
	sd s1, 64(sp)
	sd a0, 72(sp)
	sd a1, 80(sp)
	sd a2, 88(sp)
	sd a3, 96(sp)
	sd a4, 104(sp)
	sd a5, 112(sp)
	sd a6, 120(sp)
	sd a7, 128(sp)
	sd s2, 136(sp)
	sd s3, 144(sp)
	sd s4, 152(sp)
	sd s5, 160(sp)
	sd s6, 168(sp)
	sd s7, 176(sp)
	sd s8, 184(sp)
	sd s9, 192(sp)
	sd s10, 200(sp)
	sd s11, 208(sp)
	sd t3, 216(sp)
	sd t4, 224(sp)
	sd t5, 232(sp)
	sd t6, 240(sp)

	mv a0, sp
	call rv_ktrap

	ld ra, 0(sp)
	ld sp, 8(sp)
	ld gp, 16(sp)
	# not tp (contains hartid), in case we moved CPUs
	ld t0, 32(sp)
	ld t1, 40(sp)
	ld t2, 48(sp)
	ld s0, 56(sp)
	ld s1, 64(sp)
	ld a0, 72(sp)
	ld a1, 80(sp)
	ld a2, 88(sp)
	ld a3, 96(sp)
	ld a4, 104(sp)
	ld a5, 112(sp)
	ld a6, 120(sp)
	ld a7, 128(sp)
	ld s2, 136(sp)
	ld s3, 144(sp)
	ld s4, 152(sp)
	ld s5, 160(sp)
	ld s6, 168(sp)
	ld s7, 176(sp)
	ld s8, 184(sp)
	ld s9, 192(sp)
	ld s10, 200(sp)
	ld s11, 208(sp)
	ld t3, 216(sp)
	ld t4, 224(sp)
	ld t5, 232(sp)
	ld t6, 240(sp)

	addi sp, sp, 256

	sret

/** user trap vector */
.global rv_user_vec
.align 4
rv_user_vec:
	csrw sscratch, a0 /* no gprs available, use sscratch */
	li a0, RV_TRAPFRAME
	sd ra, 40(a0)
	sd sp, 48(a0)
	sd gp, 56(a0)
	sd tp, 64(a0)
	sd t0, 72(a0)
	sd t1, 80(a0)
	sd t2, 88(a0)
	sd s0, 96(a0)
	sd s1, 104(a0)
	/* this happens later: sd a0, 112(a0) */
	sd a1, 120(a0)
	sd a2, 128(a0)
	sd a3, 136(a0)
	sd a4, 144(a0)
	sd a5, 152(a0)
	sd a6, 160(a0)
	sd a7, 168(a0)
	sd s2, 176(a0)
	sd s3, 184(a0)
	sd s4, 192(a0)
	sd s5, 200(a0)
	sd s6, 208(a0)
	sd s7, 216(a0)
	sd s8, 224(a0)
	sd s9, 232(a0)
	sd s10, 240(a0)
	sd s11, 248(a0)
	sd t3, 256(a0)
	sd t4, 264(a0)
	sd t5, 272(a0)
	sd t6, 280(a0)

	/* save a0, which is in sscratch */
	csrr t0, sscratch
	sd t0, 112(a0)

	ld tp, 32(a0) /* kernel hartid */
	ld t0, 16(a0) /* kernel trap handler. TODO: why do we need this? */
	ld sp, 8(a0) /* kernel stack pointer */
	ld t1, 0(a0) /* get the kernel satp */

	/* use the kernel page table */
	sfence.vma zero, zero
	csrw satp, t1
	sfence.vma zero, zero

	jr a0 /* jump to the trap handler */

/** user trap return */
/** void rv_user_ret(void *satp)  */
.global rv_user_ret
.align 4
rv_user_ret:
	/* use the provided page table */
	sfence.vma zero, zero
	csrw satp, a0
	sfence.vma zero, zero

	li a0, RV_TRAPFRAME

	csrw sscratch, a0 /* no gprs available, use sscratch */
	li a0, RV_TRAPFRAME
	sd ra, 40(a0)
	sd sp, 48(a0)
	sd gp, 56(a0)
	sd tp, 64(a0)
	sd t0, 72(a0)
	sd t1, 80(a0)
	sd t2, 88(a0)
	sd s0, 96(a0)
	sd s1, 104(a0)
	/* this happens later: sd a0, 112(a0) */
	sd a1, 120(a0)
	sd a2, 128(a0)
	sd a3, 136(a0)
	sd a4, 144(a0)
	sd a5, 152(a0)
	sd a6, 160(a0)
	sd a7, 168(a0)
	sd s2, 176(a0)
	sd s3, 184(a0)
	sd s4, 192(a0)
	sd s5, 200(a0)
	sd s6, 208(a0)
	sd s7, 216(a0)
	sd s8, 224(a0)
	sd s9, 232(a0)
	sd s10, 240(a0)
	sd s11, 248(a0)
	sd t3, 256(a0)
	sd t4, 264(a0)
	sd t5, 272(a0)
	sd t6, 280(a0)

	/* save a0, which is in sscratch */
	csrr t0, sscratch
	sd t0, 112(a0)

	ld tp, 32(a0) /* kernel hartid */
	ld t0, 16(a0) /* kernel trap handler. TODO: why do we need this? */
	ld sp, 8(a0) /* kernel stack pointer */
	ld t1, 0(a0) /* get the kernel satp */

	/* use the kernel page table */
	sfence.vma zero, zero
	csrw satp, t1
	sfence.vma zero, zero

	jr a0 /* jump to the trap handler */
