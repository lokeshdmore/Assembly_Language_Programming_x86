#include<stdio.h>
#include<stdlib.h>


int main(void)
{
    // code
    long long int iNumerator;
    int iDenominator, quotient, remainder;


    printf("Enter operand 1: \t");
    scanf("%d", &iNumerator);

    printf("Enter operand 2: \t");
    scanf("%d", &iDenominator);

    quotient = iNumerator / iDenominator;

    printf("quotient = %d\n", quotient);

    remainder = iNumerator % iDenominator;

    printf("remainder = %d\n", remainder);

    exit(0);
}