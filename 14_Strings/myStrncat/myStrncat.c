#include<stdio.h>

char* myStrcat(char *pszDest, const char* pszSrc, int n);

int main(void)
{
    char str1[256];
    char str2[128];
    printf("Enter your first string : ");
    gets(str1);

    printf("Enter your second string : ");
    gets(str2);

    char* str = myStrcat(str1, str2, 5);

    printf("your concetenate string is \"%s\"\n", str);

    return(0);
}

char* myStrcat(char *pszDest, const char* pszSrc, int n)
{
    int iCounter1 = 0;
    while(pszDest[iCounter1] != '\0')
    {
        iCounter1++;
    }
    int i;
    for(i=0; i < n; i++)
    {
        if(pszSrc[i] == '\0')
        {
            break;
        }
        pszDest[iCounter1] = pszSrc[i];
        iCounter1++;
    }
    pszDest[iCounter1] = '\0';

    return pszDest;

}