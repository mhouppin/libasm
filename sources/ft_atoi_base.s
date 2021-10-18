%include "kernel_symbols.s"

section .text
    global C_FUNCTION(ft_atoi_base)

C_FUNCTION(ft_atoi_base):
    xor eax, eax

.loop_space:
    movzx rdx, byte [rdi]
    cmp rdx, 32
    ja .check_sign
    mov rcx, 0x100003e00
    bt rcx, rdx
    jae .check_sign
    inc rdi
    jmp .loop_space

.check_sign:
    mov r8b, 0
    cmp esi, 10
    je .check_digits
    mov dl, byte [rdi]
    cmp dl, 43
    je .skip_sign
    cmp dl, 45
    sete r8b
    jne .check_digits

.skip_sign:
    inc rdi

.check_digits:
    movzx edx, byte [rdi]
    mov r9d, edx
    sub r9d, 48
    cmp r9d, 10
    jb .check_valid_base
    mov r9d, edx
    sub r9d, 97
    cmp r9d, 22
    jae .return
    add r9d, 10

.check_valid_base:
    cmp r9d, esi
    jae .return
    mul esi
    add eax, r9d
    inc rdi
    jmp .check_digits

.return:
    mov ecx, eax
    neg ecx
    test r8b, r8b
    cmovz eax, ecx
    ret
