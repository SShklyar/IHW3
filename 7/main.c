#include <stdio.h>

#define EPS 0.005

double ch(double x) {
    int i = 1;
    double t, k, p, eps = 1;
    t = 1;
    p = 1;
    k = 1;
    while (eps > EPS) {
        p = p * x; // x ^ i
        k *= i; // i!
        if (i % 2 == 0) { // i - четное
            eps = (p / k);
            t += eps;
        }
        ++i;
    }
    return t;
}

int main(int argc, char *argv[]) {
    if (argc != 3) {
        fprintf(stdout, "Invalid number of arguments!");
    }
    if (freopen(argv[1], "r", stdin) == NULL) {
        fprintf(stdout, "Error opening input file!");
    }
    if (freopen(argv[2], "w", stdout) == NULL) {
        fprintf(stdout, "Error opening output file!");
    }
    double x;
    scanf("%lf", &x);
    printf("%lf", ch(x));
    return 0;
}