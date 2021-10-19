#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

typedef struct s_list
{
    void *data;
    struct s_list *next;
}
t_list;

ssize_t ft_read(int fd, void *b, size_t nbytes);
int ft_strcmp(const char *s1, const char *s2);
char *ft_strcpy(char *dst, const char *src);
char *ft_strdup(const char *str);
size_t ft_strlen(const char *str);
ssize_t ft_write(int fd, const void *b, size_t nbytes);
int ft_atoi_base(const char *s, int base);

int ft_list_push_front(t_list **listRef, void *data);
size_t ft_list_size(t_list *list);
void ft_list_sort(t_list **listRef, int (*comp)(const void *, const void *));
void ft_list_remove_if(t_list **listRef, int (*filter)(const void *), void (*del)(void *));

void ft_putstr(const char *s)
{
    ft_write(STDOUT_FILENO, s, ft_strlen(s));
}

void print_list(t_list *list)
{
    for (t_list *i = list; i; i = i->next)
        ft_putstr(i->data);
}

int filter_str(const void *data)
{
    return !isalnum(*(const char *)data);
}

int compare(const void *a, const void *b)
{
    return ft_strcmp(a, b);
}

int main(void)
{
    t_list *list = malloc(sizeof(t_list));
    t_list *iter = list;
    list->data = ft_strdup("# Prologue\n");
    char *line = NULL;
    size_t size = 0;

    while (getline(&line, &size, stdin) > 0)
    {
        iter->next = malloc(sizeof(t_list));
        iter->next->data = ft_strdup(line);
        iter = iter->next;
    }
    iter->next = NULL;

    free(line);

    ft_putstr("--->\n");
    print_list(list);
    ft_putstr("<---\n \n--->\n");
    ft_list_remove_if(&list, &filter_str, &free);
    print_list(list);
    ft_putstr("<---\n \n--->\n");
    ft_list_sort(&list, &compare);
    print_list(list);
    ft_putstr("<---\n");

    return 0;
}
