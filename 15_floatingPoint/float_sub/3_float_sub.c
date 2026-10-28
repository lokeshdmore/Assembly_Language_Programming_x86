#include <stdio.h>
#include <stdlib.h>

float fNo1 = 10.22f;
float fNo2 = 20.22f;
float fAns1;
float fAns2;
float fAns3;

int main()
{
    printf("fNo1 = %f\nfNo2 = %f\n", fNo1, fNo2);

    fAns1 = fNo2 - fNo1;
    fAns2 = fNo1 - fNo2;
    fAns3 = fNo1 - 5;

    printf("fAns1 = %f\t\n", fAns1);
    printf("fAns2 = %f\t\n", fAns2);
    printf("fAns3 = %f\t\n", fAns3);

    exit(0);
}
