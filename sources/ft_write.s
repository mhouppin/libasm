%include "kernel_symbols.s"

section .text
    global C_FUNCTION(ft_write)
%ifdef MACOS_KERN
    extern ___error
%else
    extern __errno_location
%endif

C_FUNCTION(ft_write):
%ifdef MACOS_KERN

    mov rax, 0x2000004
    syscall
    jb .error
    ret

.error:
    push rax
    call ___error
    pop rdi
    mov dword [rax], edi
    mov rax, -1
    ret

%else
    mov rax, 1
    syscall
    cmp rax, 0
    jl .error
    ret

.error:
    neg rax
    push rax
    call __errno_location
    pop rdi
    mov dword [rax], edi
    mov rax, -1
    ret

%endif