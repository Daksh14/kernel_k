asm (
    ".section .entry\n\t"
    "xor dh, dh\n\t"
    "push edx\n\t"

    // Zero out .bss
    "xor al, al\n\t"
    "lea edi, bss_begin\n\t"
    "lea ecx, bss_end\n\t"
    "lea edx, bss_begin\n\t"
    "sub ecx, edx\n\t"
    "rep stosb\n\t"

    "call main\n\t"
);


void main() {
	char* buffer=0xb8000;
    char* end=0xb8fff;
    for(char* c=buffer;c!=end;c++)*c='\0';
    //*buffer='%';
	while(1);
}
