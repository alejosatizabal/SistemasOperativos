Integrantes:<br>
Jesús Ramírez - 1731388<br>
Alejandro Satizabal - 1726041<br>

<hr>

Para este trabajo tuvimos la dificultad de desplegar las máquinas virtuales en AWS, por tanto, tomamos la opción de manejar el despliegue y aprovisionamiento de las máquinas virtuales de forma local, usando <b>Vagrant</b> y <b>Ansible</b>

<hr>

## Video demostrativo:
<a href="https://www.youtube.com/watch?v=jiZksAmInKc">Video en YouTube</a>

## Códigos usados:
<a href="https://github.com/alejosatizabal/SistemasOperativos/tree/master/haproxy-ansible/haproxy1/haproxy.cfg">haproxy.cfg</a>
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
<pre><code>

Vagrant.configure("2") do |config|

    config.vm.box = "ubuntu/xenial64"
    config.vm.define "web01" do |web|
       web.vm.network "private_network", ip: "192.168.200.3"
       web.vm.synced_folder "./web01", "/var/www/html"
       web.vm.provider :virtualbox do |vb|
               vb.customize [ 'modifyvm', :id, '--memory', '386']
               vb.customize [ 'modifyvm', :id, '--cpus', '1']
               vb.customize [ 'modifyvm', :id, '--name', 'web01']
       end
       web.vm.provision "ansible" do |ansible|
              ansible.playbook= "web.yml"
          end
    end
    
    config.vm.define "web02" do |web|
        web.vm.network "private_network", ip: "192.168.200.4"
        web.vm.synced_folder "./web02", "/var/www/html"
        web.vm.provider :virtualbox do |vb|
		vb.customize [ 'modifyvm', :id, '--memory', '386' ]
		vb.customize [ 'modifyvm', :id, '--cpus', '1' ]
		vb.customize [ 'modifyvm', :id, '--name', 'web02' ]
        end
        web.vm.provision "ansible" do |ansible|
              ansible.playbook= "web.yml"
          end
        
    end
    
    config.vm.define "haproxy" do |hap|
        hap.vm.network "private_network", ip: "192.168.200.5"
        hap.vm.synced_folder "./haproxy1", "/var/www/html"
        hap.vm.provider :virtualbox do |vb|
		vb.customize [ 'modifyvm', :id, '--memory', '386' ]
		vb.customize [ 'modifyvm', :id, '--cpus', '1' ]
		vb.customize [ 'modifyvm', :id, '--name', 'hap' ]
        end
          hap.vm.provision "ansible" do |ansible|
              ansible.playbook= "haproxy.yml"
          end

    end
  
  
end
</code></pre>

<a href="https://github.com/alejosatizabal/SistemasOperativos/blob/master/haproxy-ansible/haproxy.yml">haproxy.yml</a><br>
<pre><code>
---


- hosts: all
  become: yes   

  tasks:

  - name: install haproxy
    apt: name=haproxy update_cache=yes state=latest
    
  - name: Enable init script
    replace: dest='/etc/default/haproxy' 
         regexp='ENABLED=0'
         replace='ENABLED=1'   
         
  - name: cambiar haproxy cfg
    command: mv haproxy.cfg haproxy.cfg.original
    args:
     chdir: /etc/haproxy

  - name: actualizar haproxy
    template:
      src: ./haproxy1/haproxy.cfg
      dest: /etc/haproxy/haproxy.cfg
      
  - name: start haproxy
    systemd:
      name: haproxy
      enabled: yes
      state: started
      
  - name: restart haproxy
    systemd:
      name: haproxy
      enabled: yes
      state: reloaded
</code></pre>

<a href="https://github.com/alejosatizabal/SistemasOperativos/blob/master/haproxy-ansible/web.yml">web.yml</a><br>
<pre><code>
---

- hosts: all
  become: yes

  tasks:

  - name: install apache
    apt: name=apache2 update_cache=yes state=installed
</code></pre>
