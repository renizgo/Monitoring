
# Implementation the Monitoring Stack

## Preparing enviroment

**Install packages**

```$ sudo apt-get install curl wget git```

**Install Docker and Docker-Compose**
I will install second a [documentation official](https://docs.docker.com/install/linux/docker-ce/ubuntu/#os-requirements):

```
$ sudo apt-get remove docker docker-engine docker.io
$ sudo apt-get update
$ sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
$ sudo add-apt-repository    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \ $(lsb_release -cs) \ stable"
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

Exit your terminal and reopen and run command:
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
$ mkdir /opt/monitoring
$ cd /opt/monitoring/
$ git clone https://github.com/renizgo/Monitoring.git
$ sudo chown nobody. Monitoring/ -R
$ cd Monitoring
```

**Create a network in Docker**
```
$ docker network create monitoring
```

**Iptables flush rules**
```
$ sudo iptables --flush
```

**Run a Docker Compose**
```
$ docker-compose up
```

Open your browser with the URLs:

Prometheus
http://localhost:9090

Node-Exporter
http://localhost:9100

AlertManager
http://localhost:9093

Netdata
http://localhost:19999

Cadivisor
http://localhost:8080

Grafana
http://localhost:8080

Hope this helps
