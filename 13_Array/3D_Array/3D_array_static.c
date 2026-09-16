#include <stdio.h>
#include <stdlib.h>

#define MAX 10

int main()
{
    int iPlanes;
    int iRows;
    int iColumns;
    int iCounter1;
    int iCounter2;
    int iCounter3;
    int arr[MAX][MAX][MAX];

    printf("Enter value of planes, rows & columns(< %d):\t", MAX);
    scanf("%d%d%d", &iPlanes, &iRows, &iColumns);

    for(iCounter1 = 0; iCounter1 < iPlanes; iCounter1++)
    {
        for(iCounter2 = 0; iCounter2 < iRows; iCounter2++)
        {
            for(iCounter3 = 0; iCounter3 < iColumns; iCounter3++)
            {
                printf("Enter [%d][%d][%d] value:\t", iCounter1, iCounter2, iCounter3);
                scanf("%d", &arr[iCounter1][iCounter2][iCounter3]);
            }
        }
    }

    printf("Entered elements are:\n");

    for(iCounter1 = 0; iCounter1 < iPlanes; iCounter1++)
    {
        for(iCounter2 = 0; iCounter2 < iRows; iCounter2++)
        {
            for(iCounter3 = 0; iCounter3 < iColumns; iCounter3++)
            {
                printf("[%d][%d][%d] value is:\t%d\n",
                       iCounter1, iCounter2, iCounter3,
                       arr[iCounter1][iCounter2][iCounter3]);
            }
        }
    }

    exit(0);
}
