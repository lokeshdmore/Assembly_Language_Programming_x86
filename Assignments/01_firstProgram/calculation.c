#include<stdio.h>

int addition(int no1, int no2);

int main(void)
{
    int no1, no2, ans;

    printf("Enter two numbers : ");
    
    scanf("%d%d", &no1, &no2);

    ans = addition(no1, no2);

    printf("Addition is %d\n", ans);

    exit(0);
}

int addition(int no1, int no2)
{
    int sum;
    sum = no1 + no2;

    return sum;
}