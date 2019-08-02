#include <stdio.h>
#include <stdlib.h>
#include "common.h"
#include "common_threads.h"
#include "mycommon.h"
#include "pthread.h"
#include <pthread.h>
#include <time.h>

volatile int counter = 0;
int loops;
puerta door;

clock_t tA_ini, tA_fin, tB_ini, tB_fin;
double segundosA, segundosB;

void *worker(void *arg) {
    int i;
	
	// TIEMPO A-Inicio
	tA_ini = clock();
    for (i = 0; i < loops; i++) {
        cerrar_puerta(door);
        // TIEMPO B-Inicio
        tB_ini = clock();
        counter++;
        abrir_puerta(door);
        // TIEMPO B-Fin
        tB_fin = clock();
    }
    // TIEMPO A-Fin
    tA_fin = clock();

    return NULL;
}

int main(int argc, char *argv[]) {
    if (argc != 2) {
	fprintf(stderr, "usage: threads <loops>\n");
	exit(1);
    }
    crear_puerta(door);
    loops = atoi(argv[1]);
    pthread_t p1, p2;
    // printf("Initial value : %d\n", counter);
    Pthread_create(&p1, NULL, worker, NULL);
    Pthread_create(&p2, NULL, worker, NULL);
    Pthread_join(p1, NULL);
    Pthread_join(p2, NULL);
    destruir_puerta(door);
    // printf("Final value   : %d\n", counter);
    
    segundosA = (double)(tA_fin - tA_ini) / CLOCKS_PER_SEC;
	printf("Fuera del for se demora: %.16g milisegundos\n", segundosA * 1000.0);
  
	segundosB = (double)(tB_fin - tB_ini) / CLOCKS_PER_SEC;
	printf("Dentro del for se demora: %.16g milisegundos\n", segundosB * 1000.0);

    return 0;
}
