#include<stdio.h>

int myStrcmp(const char *pszStr1, const char* pszStr2);

int main(void)
{
    char str1[256];
    char str2[128];
    printf("Enter your first string : ");
    gets(str1);

    printf("Enter your second string : ");
    gets(str2);

    int diff = myStrcmp(str1, str2);
    if(diff == 0)
    {
        printf("both strings are equal\n");
    }
    else
    {
        printf("both strings are unequal\n");
    }
    
    return(0);
}

int myStrcmp(const char *pszStr1, const char* pszStr2)
{
    int iCounter1 = 0;
    while((pszStr1[iCounter1] != '\0') && (pszStr2[iCounter1] != '\0'))
    {
        if((pszStr1[iCounter1]) != (pszStr2[iCounter1]))
        {
            break;
        }
        iCounter1++;
    }

    return ((pszStr1[iCounter1]) - (pszStr2[iCounter1]));
}