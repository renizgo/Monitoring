
# Implementation the Monitoring Stack

## Preparing enviroment

**Install packages**

```$ sudo apt-get install curl wget git```

**Install Docker and Docker-Compose**
I will install second a [documentation official](https://docs.docker.com/install/linux/docker-ce/ubuntu/#os-requirements):

```
$ sudo apt-get remove docker docker-engine docker.io
$ sudo apt-get update
$ sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
$ sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
$ sudo apt-get update
$ sudo apt-get install docker-ce
$ sudo docker --version
$ sudo apt install docker-compose
$ sudo docker-compose --version
```

**Recommend post installation process**

```
$ sudo groupadd docker
$ sudo usermod -aG docker $USER
$ sudo mkdir /home/"$USER"/.docker
$ sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
$ sudo chmod g+rwx "$HOME/.docker" -R
```

** Exit your terminal and reopen and run command:
```
$ docker run hello-world
```

**For more agility run docker pull images**
```
docker pull prom/prometheus
docker pull quay.io/prometheus/node-exporter
docker pull prom/alertmanager
docker pull grafana/grafana
docker pull google/cadvisor
docker pull netdata/netdata
```

**Create a directory and run Git Clone Project**
```
$ cd ~
$ git clone https://github.com/renizgo/Monitoring.git
$ cd Monitoring
$ sudo find ../Monitoring/ -type d -exec chmod 777  "{}" \;
$ sudo find ../Monitoring/ -type f -exec chmod 666  "{}" \;
```

**Create a network in Docker**
```
$ docker network create monitoring
```

** Disable firewall
```
$ sudo ufw disable
```

**Change ips "Your IP" in ```prometheus-config/prometheus.yml``` archive, for example:
```
  - job_name: 'prometheus'
    static_configs:
    - targets: ['<YOUR_IP>:9090']
```

** Edit also ```nginx-config/nginx.conf``` with your IP
```
server {
  listen 80;
  server_name exporter.monitor;
  location / {
      proxy_pass http://<YOUR_IP>:9100/;
  }
}
```

** Edit your ```/etc/hosts``` 
<YOUR_IP>  prometheus.monitor
<YOUR_IP>  exporter.monitor
<YOUR_IP>  grafana.monitor
<YOUR_IP>  netdata.monitor
<YOUR_IP>  cadvisor.monitor
<YOUR_IP>  alertmanager.monitor

** Restart server
```
$ sudo reboot
```


**Run a Docker Compose**
```
$ cd ~/Monitoring
$ docker-compose up
```

Open your browser with the URLs:

Prometheus
http://prometheus.monitor

Node-Exporter
http://exporter.monitor

AlertManager
http://alertmanager.monitor

Netdata
http://netdata.monitor

Cadivisor
http://cadvisor.monitor

Grafana
http://grafana.monitor

Hope this helps
