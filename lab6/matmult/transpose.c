#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <sys/time.h>

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

int main(int argc, char **argv)
{
    int n = 5000, i, j;
    int blocksize = 20; /* to do: find a better block size */

    /* allocate an n*n block of integers for the matrices */
    int *A = (int *)malloc(n * n * sizeof(int));
    int *B = (int *)malloc(n * n * sizeof(int));

    /* initialize A,B to random integers */
    srand48(time(NULL));
    for (i = 0; i < n * n; i++)
        A[i] = lrand48();
    for (i = 0; i < n * n; i++)
        B[i] = lrand48();

    /* measure performance */
    struct timeval start, end;

    gettimeofday(&start, NULL);
    transpose(n, blocksize, B, A);
    gettimeofday(&end, NULL);

    double seconds = (end.tv_sec - start.tv_sec) + 1.0e-6 * (end.tv_usec - start.tv_usec);
    printf("%g milliseconds\n", seconds * 1e3);

    /* check correctness */
    for (i = 0; i < n; i++)
        for (j = 0; j < n; j++)
            if (B[j + i * n] != A[i + j * n])
            {
                printf("Error!!!! Transpose does not result in correct answer!!\n");
                exit(-1);
            }

    /* release resources */
    free(A);
    free(B);
    return 0;
}
