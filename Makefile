# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mhouppin <mhouppin@student.42lyon.f>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/08 12:51:43 by mhouppin          #+#    #+#              #
#    Updated: 2020/12/08 12:53:06 by mhouppin         ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

NAME = libasm.a

SOURCES = $(wildcard sources/*.s)
OBJECTS = $(SOURCES:%.s=%.o)

all: $(NAME)

$(NAME): $(OBJECTS)
	ar -rc $@ $^
	ranlib $@

%.o: %.s
	nasm -fmacho64 -o $@ $<

clean:
	rm -f $(OBJECTS)

fclean: clean
	rm -f $(NAME)

re: fclean all

.PHONY: all clean fclean re
