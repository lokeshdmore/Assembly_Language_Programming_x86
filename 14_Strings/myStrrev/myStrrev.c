#include<stdio.h>

char* myStrrev(char *pszDest);

int main(void)
{
    char str1[256];
    char ch;
    printf("Enter your string : ");
    gets(str1);

    char* str = myStrrev(str1);

    printf("your updated string is \"%s\"\n", str);

    return(0);
}

char* myStrrev(char *pszDest)
{
    int iCounter1 = 0;

    while(pszDest[iCounter1] != '\0')
    {
        iCounter1++;
    }
    iCounter1--;

    for(int i=0; i<iCounter1; i++)
    {
        char swap = pszDest[i];
        pszDest[i] = pszDest[iCounter1];
        pszDest[iCounter1] = swap;
        iCounter1--;
    }

    return pszDest;
}