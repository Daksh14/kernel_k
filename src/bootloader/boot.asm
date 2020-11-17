org		0x7c00
bits	16
KERNEL_OFFSET equ 0x7e00
init:

	cli
	jmp 0:intialise
	hlt

intialise:

    xor ax, ax
    mov ds, ax
    mov es, ax

    mov fs, ax
    mov gs, ax
    mov ss, ax

    mov sp, 0x7c00

    sti

    mov bx, LoadingMsg
    call print
    call newline
    mov ax, 0x3
	int 0x10

	jmp reset_disk


load_kernel:
	mov bx, MSG_LOAD_KERNEL
	call print
	call newline

	mov bx, KERNEL_OFFSET
	mov dh, 15
	mov dl, [BOOT_DRIVE]
	call disk_load

	ret

disk_load:
	push dx

	mov ah, 0x02
	mov al, dh
	mov ch, 0x00
	mov dh, 0x00
	mov cl, 0x02

	int 0x13

	jc disk_error
	pop dx
	cmp dh, al
	jne disk_error
	ret

disk_error:
	mov bx, DISK_ERROR_MSG
	call print
	jmp $

reset_disk:
	mov ah, 0x00
	int 0x13

	mov bx, floppydisk

	call print
	call newline

	mov ax, 0x2401
	int 0x15

	lgdt [GDT]

	mov [BOOT_DRIVE], dl

	call load_kernel

	mov bx, enteringpmode
	call print

	cli
	mov eax, cr0
	or  eax, 1
	mov cr0, eax

	jmp 0x8:Pmode


LoadingMsg:
    db 'Booting....', 0

MSG_LOAD_KERNEL:
    db 'Loading kernel....', 0

DISK_ERROR_MSG db "Disk read error!", 0

floppydisk:
    db 'Reseting floppy disk....', 0

a20_line:
    db 'Enabling a20 line', 0

enteringpmode:
    db 'Entering protected mode', 0

nocpuid:
	db 'No cupid', 0

BOOT_DRIVE db 0

%include 'bootloader/print.asm'
%include 'bootloader/a20enable.asm'
%include 'bootloader/gdt.asm'

[bits 32]

Pmode:
	mov		ax, 0x10
	mov		ds, ax
	mov     es, ax
	mov     fs, ax,
	mov     gs, ax
	mov		ss, ax

	mov		esp, 0x7BFF
	jmp KERNEL_OFFSET

times 510 - ($-$$) db 0

dw 0xAA55
