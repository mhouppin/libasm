%include "kernel_symbols.s"

section .text
    global C_FUNCTION(ft_list_size)

C_FUNCTION(ft_list_size):
    xor eax, eax

.loop:
    test rdi, rdi
    jz .return
    mov rdi, qword [rdi + 8]
    inc rax
    jmp .loop

.return:
    ret
