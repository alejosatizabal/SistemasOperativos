Integrantes:<br
Jesús Ramírez - 1731388<br>
Alejandro Satizabal - 1726041<br>

## Códigos usados:
<a href="https://github.com/alejosatizabal/SistemasOperativos/tree/master/haproxy-ansible/haproxy1/">haproxy.cfg</a>
<pre><code>
global
        log /dev/log   local0
        log 127.0.0.1   local1 notice
        maxconn 4096
        user haproxy
        group haproxy
        daemon

defaults
        log     global
        mode    http
        option  httplog
        option  dontlognull
        retries 3
        option redispatch
        maxconn 2000
        contimeout     5000
        clitimeout     50000
        srvtimeout     50000

listen webfarm
bind 0.0.0.0:80
    mode http
    stats enable
    stats uri /haproxy?stats
    balance roundrobin
    option httpclose
    option forwardfor
    server webserver01 192.168.200.3:80 check
    server webserver02 192.168.200.4:80 check
</code></pre>

<a href="https://github.com/alejosatizabal/SistemasOperativos/blob/master/haproxy-ansible/Vagrantfile">Vagrantfile</a><br>
<a href="https://github.com/alejosatizabal/SistemasOperativos/blob/master/haproxy-ansible/haproxy.yml">haproxy.yml</a><br>
<a href="https://github.com/alejosatizabal/SistemasOperativos/blob/master/haproxy-ansible/web.yml">web.yml</a><br>
