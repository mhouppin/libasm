; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_memcpy.s                                        :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mhouppin <mhouppin@student.42lyon.f>       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2020/12/08 12:57:53 by mhouppin          #+#    #+#              ;
;    Updated: 2020/12/08 12:59:41 by mhouppin         ###   ########lyon.fr    ;
;                                                                              ;
; **************************************************************************** ;

section .text
    global  _ft_memcpy

_ft_memcpy:
    mov     rax,    rdi

.loop:
    cmp     rdx,        0
    je      .return
    mov     cl,         byte [rsi]
    mov     byte [rdi], cl
    inc     rdi
    inc     rsi
    dec     rdx
    jmp     .loop

.return:
    ret
