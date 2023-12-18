#include "aock/trap.h"
#include "aock/arch/rv64/core.h"

static void init_kernel_();
static void init_user_();

void trap_init() {
	init_kernel_();
	init_user_();
}

static void init_kernel_() {
	extern void rv_ktvec();
	rv_write_stvec((uptr)&rv_ktvec);
}

static void init_user_() {

}

typedef enum {
	TRAP_UNKNOWN,
	TRAP_EXTERNAL,
	TRAP_SOFTWARE,
} trap_type;

static int get_trap_type_(rv_dword scause) {
	if((scause & 0x8000000000000000L) && (scause & 0xff) == 9) {
		// this is a supervisor external interrupt, via PLIC.

		PANIC("TODO: PLIC and friends");

		// // irq indicates which device interrupted.
		// int irq = plic_claim();

		// if(irq == UART0_IRQ){
		// 	uartintr();
		// } else if(irq == VIRTIO0_IRQ){
		// 	virtio_disk_intr();
		// } else if(irq){
		// 	printf("unexpected interrupt irq=%d\n", irq);
		// }

		// // the PLIC allows each device to raise at most one
		// // interrupt at a time; tell the PLIC the device is
		// // now allowed to interrupt again.
		// if(irq)
		// 	plic_complete(irq);

		return TRAP_EXTERNAL;
	} else if(scause == 0x8000000000000001L){
		// software interrupt from a machine-mode timer interrupt,
		// forwarded by timervec in kernelvec.S.

		// if(cpuid() == 0){
		// 	clockintr();
		// }

		// acknowledge the software interrupt by clearing
		// the SSIP bit in sip.
		rv_write_sip(rv_read_sip() & ~2);

		return TRAP_SOFTWARE;
	} else {
		return TRAP_UNKNOWN;
	}
}

static const char *scause_to_str_(rv_dword scause) {
	switch (scause) {
		case 0xf: return "store page fault";
		default: return "unknown";
	}
}

void rv_ktrap() {
	rv_dword sepc = rv_read_sepc();
	rv_dword sstatus = rv_read_sstatus();
	rv_dword scause = rv_read_scause();

	if ((sstatus & RV_SSTATUS_SPP) == 0) {
		PANIC("trapped not from supervisor: {x64}", sstatus);
	}

	if (sstatus & RV_SSTATUS_SIE) {
		PANIC("interrupts enabled");
	}

	trap_type tt = get_trap_type_(scause);
	if (tt == TRAP_UNKNOWN) {
		PANIC(
			"kernel exception: {z}\nscause={p}, sepc={p}, stval={p}",
			scause_to_str_(scause), scause, sepc, rv_read_stval()
		);
	}

	// rv_write_sepc(sepc);
	// rv_write_sstatus(sstatus);


}
