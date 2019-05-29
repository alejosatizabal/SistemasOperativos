# Lenguaje C - 101

En esta clase se hizo una revisión muy rápida de un programa sencillo en C que imprime el mensaje hola mundo
Después se mostró la forma como se genera una librería de enlace estático y como la funcionalidad implementada en esta es invocada desde un programa en C.

Se desarrollaron tres programas

<ul>
  <li> <a href="https://github.com/alejosatizabal/SistemasOperativos/blob/master/2019_05_24/basico.c">basico.c</a></li>
  <li> <a href="https://github.com/alejosatizabal/SistemasOperativos/blob/master/2019_05_24/libfun.c">libfun.c</a></li>
  <li> <a href="https://github.com/alejosatizabal/SistemasOperativos/blob/master/2019_05_24/libfun.h">libfun.h</a></li>
</ul>
Para complilar el programa se llevan a cabo los siguientes pasos:

<ul>
  <li>Generar la librería</li>
</ul>

gcc -c libfun.c -o libfun.o
ar rcs libfun.a libfun.o

<ul>
  <li>En el paso anterios se generó el archivo libfun.a. Ahora enlazaremos el programa basico.c con la librería libfun.a</li>
</ul>

gcc basico.c -L. -lfun -o basico

<ul>
  <li>Finalmente, el programa se ejecuta:</li>
</ul>

./basico
