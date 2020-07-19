GDT:
	dw end - start - 1
	dd start
start:

.null_segment:
  dd 0x0
  dd 0x0

.code_segment:
   dw 0xFFFF
    dw 0x0
    db 0x0
    db 10011010b
    db 11001111b
    db 0x0

 .data_segment:
 	dw 0xFFFF
    dw 0x0
    db 0x0
    db 10010010b
    db 11001111b
    db 0x0
end: