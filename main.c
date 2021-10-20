#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

typedef struct s_list
{
    void *data;
    struct s_list *next;
}
t_list;

int ft_strcmp(const char *s1, const char *s2);

int ft_atoi_base(const char *s, int base);
int ft_list_push_front(t_list **listRef, void *data);
void ft_list_remove_if(t_list **listRef, int (*filter)(const void *), void (*del)(void *));
size_t ft_list_size(t_list *list);
void ft_list_sort(t_list **listRef, int (*comp)(const void *, const void *));

void print_list(t_list *list)
{
    for (t_list *i = list; i; i = i->next)
        printf("[%s]\n", i->data);
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
    t_list *list = NULL;
    char *line = NULL;
    size_t size = 0;

    while (getline(&line, &size, stdin) > 0)
    {
        char *ptr = strchr(line, '\n');

        if (ptr)
            *ptr = '\0';

        ft_list_push_front(&list, strdup(line));
    }

    free(line);

    printf("Initial list: %zu items\n", ft_list_size(list));
    print_list(list);
    ft_list_remove_if(&list, &filter_str, &free);
    printf("\nAfter filtering all items not starting with a letter or a number: %zu items\n",  ft_list_size(list));
    print_list(list);
    puts("\nAfter sorting all items in the ASCII order:");
    ft_list_sort(&list, &compare);
    print_list(list);
    puts("\n");

    char b10[3], b8[3], b16[3];

    for (int i = 0; i < 50; ++i)
    {
        sprintf(b10, "%d", i);
        sprintf(b8, "%o", i);
        sprintf(b16, "%x", i);

        printf("('%s', 10) -> %d, ('%s', 8) -> %d, ('%s', 16) -> %d\n",
            b10, ft_atoi_base(b10, 10),
            b8, ft_atoi_base(b8, 8),
            b16, ft_atoi_base(b16, 16));
    }

    return 0;
}
