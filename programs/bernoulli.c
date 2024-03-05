#include <stdio.h>
#include <stdlib.h>

double evalBernoulli(int totalInstances, int positiveInstances,
                     int positiveVariations, int totalVariations);

int main(int argc, char *argv[]) {
  if (argc < 5) {
    printf("Usage: %s <totalInstances> <positiveInstances> <negativeInstances> "
           "<positiveVariations> <totalVariations>\n",
           argv[0]);
    return 1;
  }

  int totalInstances = atoi(argv[1]);
  int positiveInstances = atoi(argv[2]);
  int positiveVariations = atoi(argv[3]);
  int totalVariations = atoi(argv[4]);

  if (totalInstances <= 0 || positiveInstances <= 0 ||
      positiveVariations <= 0 || totalVariations <= 0) {
    printf("All values must be greater than zero and integers.");
    return 1;
  }

  if (totalInstances < positiveInstances) {
    printf("totalInstances must be greater than positiveInstances");
    return 1;
  }

  double result = evalBernoulli(totalInstances, positiveInstances,
                                positiveVariations, totalVariations);

  printf("%f%%", result * 100.0);

  return 0;
}

double evalBernoulli(int totalInstances, int positiveInstances,
                     int positiveVariations, int totalVariations) {
  int negativeInstances = totalInstances - positiveInstances;

  double combinations = totalInstances;
  double combinations2 = 1;

  double positive = (double)positiveVariations / totalVariations;
  double negative = 1 - positive;

  double cSumTop, cSumBottom, positiveSum, negativeSum;
  cSumTop = cSumBottom = positiveSum = negativeSum = 1;

  for (int i = 0; i < positiveInstances; ++i) {
    cSumTop *= (combinations - i);
    cSumBottom *= (combinations2 + i);
    positiveSum *= positive;
  }

  for (int i = 0; i < negativeInstances; ++i) {
    negativeSum *= negative;
  }

  return (cSumTop / cSumBottom) * positiveSum * negativeSum;
}
