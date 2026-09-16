#include <stdio.h>
#include <stdlib.h>

int main()
{
    int arr[] = {10, 20, 30, 40, 50};
    int *p[] = {arr, arr + 1, arr + 2, arr + 3, arr + 4};
    int **ptr = p;

    printf("arr = %-10d \t *arr = %-10d \t &arr = %-10d\n", arr, *arr, &arr);
    printf("p = %-10d \t *p = %-10d \t **p = %-10d\n", p, *p, **p);
    printf("ptr = %-10d \t *ptr = %-10d \t **ptr = %-10d\n", ptr, *ptr, **ptr);

    *ptr++;
    printf("ptr - p = %d \t *ptr - arr = %d \t **ptr = %d\n", ptr - p, *ptr - arr, **ptr);

    *++ptr;
    printf("ptr - p = %d \t *ptr - arr = %d \t **ptr = %d\n", ptr - p, *ptr - arr, **ptr);

    ++*ptr;
    printf("ptr - p = %d \t *ptr - arr = %d \t **ptr = %d\n", ptr - p, *ptr - arr, **ptr);

    exit(0);
}