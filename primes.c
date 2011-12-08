#include <stdio.h>
#include <stdlib.h>

unsigned long MAX = 10000000;

struct factorization {
    unsigned long small;
    unsigned long other;
};

unsigned long small_factor(
    unsigned long n,
    unsigned long *primes,
    unsigned long num_primes
) 
{
    unsigned long i;
    for (i = 0; i < num_primes; ++i) {
        unsigned long p = primes[i];
        if (p * p > n) {
            break;
        }
        if (n % p == 0) {
            return p;
        }
    }
    return 1;
}  

void factor_old(
    unsigned long n,
    struct factorization * factorizations
)
{
    if (factorizations[n].small == 1) {
        printf(" x %lu\n", n);
    }
    else {
        printf(" x %lu", factorizations[n].small);
        factor_old(factorizations[n].other, factorizations);
    }
}

void factor_new(
    unsigned long n,
    struct factorization *factorizations,
    unsigned long *primes,
    unsigned long *num_primes
)
{
    unsigned long f = small_factor(n, primes, *num_primes);
    unsigned long other = n / f;
    factorizations[n].small = f;
    factorizations[n].other = other;
    printf("%lu = %lu", n, f);
    if (f == 1) {
        // new prime
        primes[*num_primes] = n;
        *num_primes += 1;
        printf(" x %lu\n", other);
    }
    else {
        // composite
        factor_old(other, factorizations);
    }
}

void count_primes() {
    unsigned long i;
    struct factorization *factorizations;
    unsigned long *primes;
    unsigned long num_primes = 0;

    factorizations = malloc((MAX+1) * sizeof(struct factorization));
    
    // primes is very pessimistically allocated, but memory management
    // is not the point of this exercise
    primes = malloc((MAX+1) * sizeof(unsigned long));

    for (i = 2; i <= MAX; ++i) {
        factor_new(i, factorizations, primes, &num_primes);
    }
    
    printf("found %lu primes\n", num_primes);
    
    free(factorizations);
    free(primes);
}

main() {
    count_primes();
}