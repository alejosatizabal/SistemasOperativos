# 2019_06_21

El día de hoy se revisaron conceptos básicos respecto al estado en el que se puede encontrar un proceso en el Sistema Operativo: <i>Waiting, Ready, Running</i> y <i>Done.</i>

Se revisó el comanto <code>process-run.py</code> que es un aplicativo provisto por el autor del texto guía del libro

<ul>
	<li><code>process-run.py</code> aplicativo que simula la ejecución de procesos y sus operaciones o en CPU o de I/O</li>
	<li><code>README-proces-run</code> documento que describe la utilización del comando <code>process-run-py.</code></li>
</ul>

<hr>

<pre><code>./process-run-py -l 3:0,3:100 -L 3 -c -p</code></pre>

Esta ejecución lo que permite es simular la ejecución de dos procesos. Un primer proceso intensivo en I/O <code>(3:0)</code> y un segundo proceso intensivo en CPU (3:100).

Los argumentos <code>-c -p</code> dan información adicional relativa al comportamiento de los procesos en el simulador, e.g. porcentaje de uso de la CPU y de operaciones de I/O
