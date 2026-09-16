#include<stdio.h>
#include<stdlib.h>

int main(void)
{
    // code
    int iNo1;
    int iNo2;
    int iNo3;
    int iAns;

    printf("Enter three numbers : ");
    scanf("%d%d%d", &iNo1, &iNo2, &iNo3);

    iAns = iNo1 && ++iNo2 && ++iNo3;

    printf("result : %d\n", iAns);
    printf("iNo1 : %d\n", iNo1);
    printf("iNo2 : %d\n", iNo2);
    printf("iNo3 : %d\n", iNo3);
    

    exit(0);
}
