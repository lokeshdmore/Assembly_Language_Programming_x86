int Compare(float fNo1, float fNo2);

int main()
{
    int iRet;
    float fNo1;
    float fNo2;

    printf("Enter two floating point numbers:\\t");
    scanf("%f%f", &fNo1, &fNo2);

    iRet = Compare(fNo1, fNo2);

    if(iRet == -1)
        puts("fNo1 is less than fNo2");
    else if(iRet == 1)
        puts("fNo1 is greater than fNo2");
    else    // 0
        puts("Values are equal");

    exit(0);
}

int Compare(float fNo1, float fNo2)
{
    if(fNo1 < fNo2)
    {
        return -1;
    }
    else if(fNo1 > fNo2)
    {
        return 1;
    }
    else
        return 0;
}
