#include<stdio.h>
#include<stdlib.h>


int main(void)
{
    // code
    int iNo1, iNo2;
    long long int lAns;

    printf("Enter operand 1: \t");
    scanf("%d", &iNo1);

    printf("Enter operand 2: \t");
    scanf("%d", &iNo2);

    lAns = iNo1 * iNo2;
    
    printf("mull answer = %d\n", lAns);


    exit(0);
}