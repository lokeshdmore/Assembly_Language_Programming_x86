#include<stdio.h>

int myStrlen(char *myStr);

int main(void)
{
    char str[30];
    printf("Enter your string : ");
    //scanf("%s",str);
    //fgets(str, sizeof(str), stdin);
    gets(str);
    int length = myStrlen(str);

    printf("your string : %s has length of %d bytes\n", str, length);


    return(0);
}

int myStrlen(char *myStr)
{
    int length = 0;
    while(myStr[length] != '\0')
    {
        length++;
    }

    return length;
}