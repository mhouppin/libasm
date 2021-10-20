#include <fcntl.h>
#include <stdlib.h>
#include <unistd.h>

ssize_t ft_read(int fd, void *b, size_t nbytes);
char *ft_strcpy(char *dst, const char *src);
char *ft_strdup(const char *str);
size_t ft_strlen(const char *str);
ssize_t ft_write(int fd, const void *b, size_t nbytes);

int main(int argc, char **argv)
{
    int fd = (argc == 2) ? open(argv[1], O_RDONLY) : STDIN_FILENO;

    char buffer[128];
    char bufcopy[128];

    ssize_t ret = ft_read(fd, buffer, 127);
    while (ret > 0)
    {
        buffer[ret] = '\0';

        char *ptr = ft_strcpy(bufcopy, buffer);
        char *next = ft_strdup(ptr);

        ft_write(STDOUT_FILENO, next, ft_strlen(next));

        free(next);

        ret = ft_read(fd, buffer, 127);
    }
}
