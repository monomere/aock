.section .init

.option norvc

.global kernel_entry
kernel_entry:
.option push
.option norelax
	la gp, __global_pointer$
.option pop

	/* clear the bss section: */
	la t1, __bss_start
	la t2, __bss_end
1:
	sd zero, (t1)	/* store zero */
	addi t1, t1, 8 /* move forward 8 bytes */
	bltu t1, t2, 1b /* if t1 < t2, goto 1b */

	la sp, __stack_top /* set the stack pointer */

	mv tp, a0 /* set the thread pointer to the hartid */
	j kernel_main

kernel_park:
	wfi
	j kernel_park
