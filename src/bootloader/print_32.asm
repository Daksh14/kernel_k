print_32:
push eax
mov eax, 0xb8000

loop:
	cmp dword [ebx], 0
   	jz return
	mov [eax], ebx
	add ebx,1
	add eax,1
	mov byte [eax], 07h
	add eax,1
	jmp loop

return:
	pop eax
	ret
