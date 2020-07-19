print:
    mov ah, 0x0e
    mov al, [bx]
    cmp al, 0
    jz done
    int 10h
    add bx, 1
    jmp print

done:
    ret

newline:
	mov al, 0x0a
    int 10h
    mov al, 0x0d
    int 10h
    ret