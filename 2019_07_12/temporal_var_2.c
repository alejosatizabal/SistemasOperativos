#include <stdio.h>

int suma(int *x, int y){
  int z;
  *x = *x + y;
  z = *x;
  return z;
}

int main(int argc, char** argv){
  int x1=4,y1=5;
  printf("Suma; %d\n", suma(&x1,y1));
  printf("x=%d\n", x1);
  return 0;
}
