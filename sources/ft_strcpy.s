%include "kernel_symbols.s"

section .text
    global C_FUNCTION(ft_strcpy)

C_FUNCTION(ft_strcpy):
    mov rax, rdi

.loop:
    mov sil, byte [rsi]
    mov byte [rdi], sil
    test sil, sil
    je .return
    inc rsi
    inc rdi
    jmp .loop

.return:
    ret