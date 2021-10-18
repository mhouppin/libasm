%include "kernel_symbols.s"

section .text
    global C_FUNCTION(ft_list_push_front)
    extern C_FUNCTION(malloc)

C_FUNCTION(ft_list_push_front):
    push rbp
    mov rbp, rsp
    push rdi
    push rsi
    mov rdi, 16
    call C_FUNCTION(malloc)
    test rax, rax
    jz .error
    mov rdi, qword [rsp]
    mov qword [rax], rdi
    mov rdi, qword [rsp + 8]
    mov rsi, qword [rdi]
    mov qword [rax + 8], rsi
    mov qword [rdi], rax
    xor eax, eax
    jmp .return

.error:
    mov eax, -1

.return:
    add rsp, 16
    pop rbp
    ret
