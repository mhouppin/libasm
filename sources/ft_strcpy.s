%include "kernel_symbols.s"

section .text
    global C_FUNCTION(ft_strcpy)

C_FUNCTION(ft_strcpy):
    mov rax, rdi

.loop:
    mov cl, byte [rsi]
    mov byte [rdi], cl
    cmp cl, 0
    je .return
    inc rdi
    inc rsi
    jmp .loop

.return:
    ret