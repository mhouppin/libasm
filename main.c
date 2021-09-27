#include <stdlib.h>
#include <unistd.h>

ssize_t ft_read(int fd, void *b, size_t nbytes);
int ft_strcmp(const char *s1, const char *s2);
char *ft_strcpy(char *dst, const char *src);
char *ft_strdup(const char *str);
size_t ft_strlen(const char *str);
ssize_t ft_write(int fd, const void *b, size_t nbytes);

void ft_putstr(const char *s)
{
    ft_write(STDOUT_FILENO, s, ft_strlen(s));
}

void ft_getchar(char *c)
{
    ft_read(STDIN_FILENO, c, 1);
}

int main(void)
{
    const char *test = "some string";
    char *copy = ft_strdup(test);

    if (ft_strcmp(test, copy) == 0)
        ft_putstr("It works!\n");
    else
        ft_putstr("It doesn't work...\n");

    if (ft_strcmp(test, ft_strcpy(copy, "some strinh")) < 0)
        ft_putstr("It works 2!\n");
    else
        ft_putstr("It doesn't work 2...\n");

    if (ft_strcmp(test, ft_strcpy(copy, "some strinf")) > 0)
        ft_putstr("It works 3!\n");
    else
        ft_putstr("It doesn't work 3...\n");

    ft_getchar(copy);
    copy[1] = '\0';

    ft_putstr("You wrote the char: ");
    ft_putstr(copy);
    ft_putstr("\n");
    free(copy);
}