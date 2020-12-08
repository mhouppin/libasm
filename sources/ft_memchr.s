; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_memchr.s                                        :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mhouppin <mhouppin@student.42lyon.f>       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2020/12/08 13:10:00 by mhouppin          #+#    #+#              ;
;    Updated: 2020/12/08 13:12:59 by mhouppin         ###   ########lyon.fr    ;
;                                                                              ;
; **************************************************************************** ;

section .text
    global  _ft_memchr

_ft_memchr:
    mov     rax,        rdi

.loop:
    cmp     rdx,        0
    je      .null
    cmp     byte [rax], sil
    je      .return
    inc     rax
    dec     rdx
    jmp     .loop

.null:
    xor     rax,    rax

.return:
    ret
