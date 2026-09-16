#include<stdio.h>

char* myStrupr(char *pszDest);

int main(void)
{
    char str1[256];
    char ch;
    printf("Enter your string : ");
    gets(str1);

    char* str = myStrupr(str1);

    printf("your updated string is \"%s\"\n", str);

    return(0);
}

char* myStrupr(char *pszDest)
{
    int iCounter1 = 0;

    while(pszDest[iCounter1] != '\0')
    {
        if(pszDest[iCounter1] >= 97 && pszDest[iCounter1] <= 122)
        {
            pszDest[iCounter1] = pszDest[iCounter1] - 32;
        }
        iCounter1++;
    }

    return pszDest;
}