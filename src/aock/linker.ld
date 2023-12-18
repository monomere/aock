ENTRY(kernel_entry);
 
. = 0x80200000;
 
SECTIONS {
	/* Include entry point at start of binary */
	.text : ALIGN(4K) {
		PROVIDE(__kernel_start = .);
		PROVIDE(__text_start = .);
		*(.init);
		*(.text);
	}

	.bss : ALIGN(4K) {
		PROVIDE(__text_end = .);
		PROVIDE(__data_start = .);
		PROVIDE(__bss_start = .);
		*(.bss .bss.*);
		*(.sbss .sbss.*);
		. += 4096;
		PROVIDE(__stack_top = .);
		. += 4096;
		PROVIDE(__global_pointer$ = .);
		PROVIDE(__bss_end = .);
	}

	.data : ALIGN(4K) {
		*(.data .data.*);
		*(.sdata .sdata.*);
	}
	
	.rodata : ALIGN(4K) {
		*(.rodata .rodata.*);
		*(.srodata .srodata.*);
		PROVIDE(__data_end = ALIGN(4K));
	}

	/DISCARD/ : {
		*(.eh_frame)
		*(.debug_frame)
		*(.note .note.*)
	}

	PROVIDE(__kernel_end = ALIGN(2M));
}

