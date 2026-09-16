#include<stdio.h>
#include<stdlib.h>

int main(void)
{
    int iNo1 = 10;

    int iNo2 = 20;

    int iAns1;
    
    int iAns2;

    iAns1   = ++iNo1;

    iAns2   = iNo2++;

    printf(" iNo1 = %d\n iNo2 = %d\n iAns1 = %d\n iAns2 = %d\n", iNo1, iNo2, iAns1, iAns2);

    exit(0);
}