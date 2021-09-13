%include "kernel_symbols.s"

section .text
    global C_FUNCTION(ft_strdup)
    extern C_FUNCTION(malloc)
    extern C_FUNCTION(ft_strlen)
    extern C_FUNCTION(ft_strcpy)

C_FUNCTION(ft_strdup):
    push r12
    mov r12, rdi
    call C_FUNCTION(ft_strlen)
    lea rdi, [rax + 1]
    call C_FUNCTION(malloc)
    cmp rax, 0
    je .return
    mov rdi, rax
    mov rsi, r12
    call C_FUNCTION(ft_strcpy)

.return:
    pop r12
    ret