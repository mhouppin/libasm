; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_bzero.s                                         :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: mhouppin <mhouppin@student.42lyon.f>       +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2020/12/08 12:55:27 by mhouppin          #+#    #+#              ;
;    Updated: 2020/12/08 12:56:40 by mhouppin         ###   ########lyon.fr    ;
;                                                                              ;
; **************************************************************************** ;

section .text
    global  _ft_bzero

_ft_bzero:
    xor     eax,    eax

.loop:
    cmp     rsi,        0
    je      .return
    mov     byte [rdi], al
    inc     rdi
    dec     rsi
    jmp     .loop

.return:
    ret
