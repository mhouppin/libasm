%include "kernel_symbols.s"

section .text
    global C_FUNCTION(ft_list_sort)

; Mergesort algorithm for linked lists transcripted from:
; https://gcc.gnu.org/onlinedocs/gcc-4.6.3/libstdc++/api/a00880_source.html

; [rsp + 32] -> list
; [rsp + 24] -> listRef
; [rsp + 16] -> nmerges
; [rsp + 8] -> comp
; [rsp] -> tail

; rax -> stack-to-reg variable
; rdi, rsi, rdx can be used as intermediate accumulators

; rcx (tmp) -> i, e
; rbx -> insize
; r12 -> p
; r13 -> psize
; r14 -> q
; r15 -> qsize

C_FUNCTION(ft_list_sort):
    push rbp
    mov rbp, rsp
    push r15
    push r14
    push r13
    push r12
    push rbx
    sub rsp, 40

; Prelude: store all needed variables in stack.
    mov qword [rsp + 24], rdi
    mov qword [rsp + 8], rsi
    mov rax, qword [rdi]
    mov qword [rsp + 32], rax

; If list == NULL, we have zero nodes, and we can return immediately.
    test rax, rax
    jz .return

; Initialize insize to 1.
    mov rbx, 1

.big_loop:

; Initialize p to list, and reset list and tail to NULL.
    mov rax, qword [rsp + 32]
    mov r12, rax
    xor eax, eax
    mov qword [rsp + 32], rax
    mov qword [rsp], rax

; Reset nmerges to zero.
    mov qword [rsp + 16], rax

.medium_loop:

; Loop until p is NULL.
    test r12, r12
    jz .medium_out

; There exists a merge to be done.
; Step 'insize' places along from p.
    inc qword [rsp + 16]
    mov r14, r12
    xor r13d, r13d
    xor ecx, ecx

.step_loop:
    cmp rcx, rbx
    je .step_out
    inc r13
    mov r14, qword [r14 + 8]
    inc rcx
    test r14, r14
    jnz .step_loop

.step_out:

; If q hasn't fallen off end, we have two lists to merge.
    mov r15, rbx

; Now we have two lists; merge them.
.merge_loop:
    test r13, r13
    jnz .merge_continue
    test r15, r15
    jz .merge_out
    test r14, r14
    jz .merge_out

; Decide whether next node of merge comes from p or q.
.merge_continue:

; If p is empty, e must come from q.
    test r13, r13
    jz .merge_from_q

; If q is empty, e must come from p.
    test r15, r15
    jz .merge_from_p
    test r14, r14
    jz .merge_from_p

; Otherwise whichever node is lower will be affected to e.
    mov rax, qword [rsp + 8]
    push rcx
    sub rsp, 8
    mov rdi, qword [r12]
    mov rsi, qword [r14]
    call rax
    add rsp, 8
    pop rcx
    cmp eax, 0
    jge .merge_from_q

.merge_from_p:
    mov rcx, r12
    mov r12, qword [r12 + 8]
    dec r13
    jmp .merge_epilogue

.merge_from_q:
    mov rcx, r14
    mov r14, qword [r14 + 8]
    dec r15

.merge_epilogue:

; Add the next node to the merged list.
    mov rax, qword [rsp]
    test rax, rax
    jnz .merge_add_tail
    mov qword [rsp + 32], rcx
    jmp .merge_set_tail

.merge_add_tail:
    mov qword [rax + 8], rcx

.merge_set_tail:
    mov qword [rsp], rcx
    jmp .merge_loop

.merge_out:

; Now p has stepped 'insize' places along, and q has too.
    mov r12, r14
    jmp .medium_loop

.medium_out:
    mov rax, qword [rsp]
    xor edi, edi
    mov qword [rax + 8], rdi

; If we have done only one merge, we're finished.
; Allow for nmerges == 0, the empty list case.
    mov rax, qword [rsp + 16]
    cmp rax, 1
    jbe .big_out

; Otherwise repeat, merging lists twice the size.
    add rbx, rbx
    jmp .big_loop

.big_out:

; Store the new list head in listRef.
    mov rax, qword [rsp + 32]
    mov rdi, qword [rsp + 24]
    mov qword [rdi], rax

.return:
    add rsp, 40
    pop rbx
    pop r12
    pop r13
    pop r14
    pop r15
    pop rbp
    ret
