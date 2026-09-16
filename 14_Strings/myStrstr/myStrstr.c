#include<stdio.h>

char* myStrstr(char *pszDest, const char* pszSrc);

int main(void)
{
    char str1[256];
    char str2[128];
    printf("Enter your first string : ");
    gets(str1);

    printf("Enter your second string : ");
    gets(str2);

    char* str = myStrstr(str1, str2);

    printf("your finded string is \"%s\"\n", str);

    return(0);
}

char* myStrstr(char *pszDest, const char* pszSrc)
{
    int iCounter1 = 0;
    int i=0;
    int j=0;
    char* destAddr = NULL;

    while(pszDest[iCounter1] != '\0')
    {
        if(pszDest[iCounter1] == pszSrc[i])
        {
            int i=iCounter1;
            int j=0;
            int flag = 1;
            while(pszSrc[j] != '\0')
            {
                if(pszDest[i] != pszSrc[j])
                {
                    i = 0;
                    flag = 0;
                    break;
                }
                i++;
                j++;
            }
            if(flag == 1)
            {
                destAddr = &pszDest[iCounter1]; 
                break;
            }

        }   
        iCounter1++;
    }

    return destAddr;
}