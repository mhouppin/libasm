%include "kernel_symbols.s"

; [rsp]: listRef
; [rsp + 8]: filter
; [rsp + 16]: del
; [rsp + 24]: curNode
; [rsp + 32]: prevNode

section .text
    global C_FUNCTION(ft_list_remove_if)
    extern C_FUNCTION(free)

C_FUNCTION(ft_list_remove_if):
    push rbp
    mov rbp, rsp
    sub rsp, 48

; Save all parameters to the stack.
    mov qword [rsp], rdi
    mov qword [rsp + 8], rsi
    mov qword [rsp + 16], rdx
    xor eax, eax
    mov qword [rsp + 32], rax
    mov rcx, qword [rdi]
    mov qword [rsp + 24], rcx

.loop:

; Keep removing nodes until we arrive at the end of the list.
    test rcx, rcx
    jz .return

; Check if the node needs to be deleted.
    mov rdi, qword [rcx]
    mov rax, qword [rsp + 8]
    call rax
    test eax, eax
    jz .next_iter

; If prevNode == NULL, we're removing the top node, and we need
; to update listRef to the next node in the list.
    mov rdi, qword [rsp + 32]
    test rdi, rdi
    jz .delete_head

; Link prevNode to curNode->next.
    mov rcx, qword [rsp + 24]
    mov rdx, qword [rcx + 8]
    mov qword [rdi + 8], rdx
    jmp .delete_node

.delete_head:

; Update listRef value to curNode->next.
    mov rcx, qword [rsp + 24]
    mov rdx, qword [rcx + 8]
    mov rdi, qword [rsp]
    mov qword [rdi], rdx

.delete_node:

; Delete curNode data.
    mov rdi, qword [rcx]
    mov rax, qword [rsp + 16]
    call rax

; Free curNode pointer, and set curNode to curNode->next.
    mov rdi, qword [rsp + 24]
    mov rcx, qword [rdi + 8]
    mov qword [rsp + 24], rcx
    call C_FUNCTION(free)
    mov rcx, qword [rsp + 24]
    jmp .loop

.next_iter:

; Set prevNode to curNode, and curNode to curNode->next.
    mov rcx, qword [rsp + 24]
    mov qword [rsp + 32], rcx
    mov rcx, qword [rcx + 8]
    mov qword [rsp + 24], rcx
    jmp .loop

.return:
    add rsp, 48
    pop rbp
    ret
