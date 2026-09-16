#include<stdio.h>

char* myStrset(char *pszDest, const char chChar);

int main(void)
{
    char str1[256];
    char ch;
    printf("Enter your string : ");
    gets(str1);

    printf("Enter your replacing character : ");
    scanf("%c", &ch);

    char* str = myStrset(str1, ch);

    printf("your replaced string is \"%s\"\n", str);

    return(0);
}

char* myStrset(char *pszDest, const char chChar)
{
    int iCounter1 = 0;

    while(pszDest[iCounter1] != '\0')
    {
        pszDest[iCounter1] = chChar;
        iCounter1++;
    }

    return pszDest;
}