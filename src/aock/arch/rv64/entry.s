.section .init

.option norvc

.global kernel_entry
kernel_entry:
	bnez a0, kernel_park

.option push
.option norelax
	la gp, __global_pointer$
.option pop

	# clear the bss section:
	la t1, __bss_start
	la t2, __bss_end
1:
	sd zero, (t1)	 # store zero
	addi t1, t1, 8 # move forward 8 bytes
	bltu t1, t2, 1b # if t1 < t2, goto 1b

	# set the stack pointer
	la sp, __stack_top

	mv tp, a0
	j kernel_main

kernel_park:
	wfi
	j kernel_park
