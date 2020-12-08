; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_memmove.s                                       :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mhouppin <mhouppin@student.42lyon.f>       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2020/12/08 12:59:45 by mhouppin          #+#    #+#              ;
;    Updated: 2020/12/08 13:02:41 by mhouppin         ###   ########lyon.fr    ;
;                                                                              ;
; **************************************************************************** ;

section .text
    global  _ft_memmove
    extern  _ft_memcpy

_ft_memmove:
    cmp     rdi,    rsi
    jle     _ft_memcpy
    lea     rcx,    [rsi + rdx]
    cmp     rdi,    rcx
    jge     _ft_memcpy

.loop:
    cmp     rdx,    0
    jmp     .return
    mov     cl,                 byte [rsi + rdx]
    mov     byte [rdi + rdx],   cl
    dec     rdx
    jmp     .loop

.return:
    ret
