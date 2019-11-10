#include <stdio.h>

void transpose(int n, int blocksize, int *dst, int *src)
{
    int i, j;
    /* TO DO: implement blocking (two more loops) */

    int size = n / blocksize;

    for (int ii = 0; ii < size; ii++)
    {
        for (int jj = 0; jj < size; jj++)
        {
            int dst_base = (jj * blocksize + ii * blocksize * n);
            int src_base = (ii * blocksize + jj * blocksize * n);
            // transpose out block
            for (i = 0; i < blocksize; i++)
                for (j = 0; j < blocksize; j++)
                {
                    dst[dst_base + j + i * n] = src[src_base + i + j * n];
                }
        }
    }
}

int main()
{
    int a[16] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16};
    int b[16] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};

    transpose(4, 2, b, a);

    for (int i = 0; i < 4; i++)
    {
        for (int j = 0; j < 4; j++)
        {
            printf("%d ", a[i + j * 4]);
        }
        printf("\n");
    }

    printf("===================");

    for (int i = 0; i < 4; i++)
    {
        for (int j = 0; j < 4; j++)
        {
            printf("%d ", b[i + j * 4]);
        }
        printf("\n");
    }

    return 0;
}