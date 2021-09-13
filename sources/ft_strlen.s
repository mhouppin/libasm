%include "kernel_symbols.s"

section .text
    global C_FUNCTION(ft_strlen)

C_FUNCTION(ft_strlen):
    mov rax, rdi

.loop:
    mov sil, byte [rax]
    test sil, sil
    je .return
    inc rax
    jmp .loop

.return:
    sub rax, rdi
    ret
