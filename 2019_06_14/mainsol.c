#include "solucion.h"
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int main(int argc, char** argv) {
  int x = 20;
  pid_t pid;
  
  pid = fork();
  
  if(pid==0){
    x = fibonacci(x);
    guardarEntero("archivo",x);
  }
  else{
    pid = wait(NULL);
    x = leerEntero("archivo") * 100;
    printf("%d\n",x);
  }

  return 0;
}
