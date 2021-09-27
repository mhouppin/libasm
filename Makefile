NAME = libasm.a

SOURCES = $(wildcard sources/*.s)
OBJECTS = $(SOURCES:%.s=%.o)

ASMFLAGS = -fmacho64 -DMACOS_KERN

KERNEL = $(shell uname -s)
ifeq ($(KERNEL),Linux)
	ASMFLAGS = -felf64 -DLINUX_KERN
endif

ASMFLAGS += -Iinclude

all: $(NAME)

$(NAME): $(OBJECTS)
	ar -rc $@ $^

%.o: %.s
	nasm $(ASMFLAGS) -o $@ $<

clean:
	rm -f $(OBJECTS)

fclean: clean
	$(MAKE) clean
	rm -f $(NAME)

re:
	$(MAKE) fclean
	+$(MAKE) all

.PHONY: all clean fclean re