OUTPUT_FORMAT(binary)
ENTRY(main)

SECTIONS
{
    . = 0x7e00;

    .text : {
        bootsect_begin = .;
        KEEP(*(.entry*))
        *(.text*)
    }

    .rodata : {
        *(.rodata*)
    }

    .data : {
        *(.data*)
    }

    .bss : {
        bss_begin = .;
        *(COMMON)
        *(.bss*)
        bss_end = .;
    }
}
