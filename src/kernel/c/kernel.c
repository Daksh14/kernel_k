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

#include<stdint.h>
void init_paging();

void main() {
    init_paging();
    asm (
        "push ebp\n\t"
        "mov ebp, esp\n\t"
        "mov eax, [esp+8]\n\t"
        "mov cr3, eax\n\t"
        "mov esp, ebp\n\t"
        "pop ebp\n\t"
    );
}
