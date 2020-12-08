; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_memset.s                                        :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mhouppin <mhouppin@student.42lyon.f>       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2020/12/08 12:53:16 by mhouppin          #+#    #+#              ;
;    Updated: 2020/12/08 12:55:17 by mhouppin         ###   ########lyon.fr    ;
;                                                                              ;
; **************************************************************************** ;

section .text
    global  _ft_memset

_ft_memset:
    mov     rax,    rdi

.loop:
    cmp     rdx,        0
    je      .return
    mov     byte [rdi], sil
    inc     rdi
    dec     rdx
    jmp     .loop

.return:
    ret
