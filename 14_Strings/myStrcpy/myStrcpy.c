#include<stdio.h>

char* myStrcpy(char *pszDest, const char* pszSrc);

int main(void)
{
    char str1[256];
    char str2[128];
    printf("Enter your first string : ");
    gets(str1);

    printf("Enter your second string : ");
    gets(str2);

    char* str = myStrcpy(str1, str2);

    printf("your copied string is \"%s\"\n", str);

    return(0);
}

char* myStrcpy(char *pszDest, const char* pszSrc)
{
    int iCounter1 = 0;

    while(pszSrc[iCounter1] != '\0')
    {
        pszDest[iCounter1] = pszSrc[iCounter1];
        iCounter1++;
    }

    pszDest[iCounter1] = '\0';


    return pszDest;
}