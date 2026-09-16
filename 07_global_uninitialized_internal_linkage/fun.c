#include<stdio.h>

int g_iNo;

void fun()
{
    printf("In fun, number is %d\n", g_iNo);
    printf("In fun, addr of number is %d\n", &g_iNo);
}