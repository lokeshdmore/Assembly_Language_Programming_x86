#include<stdio.h>

char* myStrrchr(char *pszStr, const char chKey);

int main(void)
{
    char str1[256];
    char ch;
    printf("Enter your string : ");
    gets(str1);

    printf("Enter your finding character : ");
    //scanf("%c", &ch);

    ch = getchar();

    char* str = myStrrchr(str1, ch);

    printf("your updated string is \"%s\"\n", str);

    return(0);
}

char* myStrrchr(char *pszStr, const char chKey)
{
    int iCounter1 = 0;

    char* pszDest = NULL;


    while(pszStr[iCounter1] != '\0')
    {
        iCounter1++;
    }
    iCounter1--;
    while(iCounter1 >= 0)
    {
        if(pszStr[iCounter1] == chKey)
        {
            pszDest = &pszStr[iCounter1];
            break;
        }
        iCounter1--;
    }
    

    return pszDest;
}