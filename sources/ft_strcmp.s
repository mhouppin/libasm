%include "kernel_symbols.s"

section .text
    global C_FUNCTION(ft_strcmp)

C_FUNCTION(ft_strcmp):
    movzx eax, byte [rdi]
    movzx ecx, byte [rsi]
    sub eax, ecx
    jnz .return
    cmp ecx, 0
    je .return
    inc rdi
    inc rsi
    jmp C_FUNCTION(ft_strcmp)

.return:
    ret