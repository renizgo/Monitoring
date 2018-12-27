
# Implementation da Stack de Monitoring

## Preparing enviroment

**Install packages**

```sudo apt-get install curl wget git```

**Install Docker and Docker-Compose**
I will install second a [documentation official](https://docs.docker.com/install/linux/docker-ce/ubuntu/#os-requirements):

```
sudo apt-get remove docker docker-engine docker.io
sudo apt-get update
sudo apt-get install     apt-transport-https     ca-certificates     curl     software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) \
stable"
sudo apt-get update
sudo apt-get install docker-ce
sudo docker --version
sudo apt install docker-compose
sudo docker-compose --version
```

**Recommend post installation process**

```
sudo groupadd docker
sudo usermod -aG docker $USER
sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
sudo chmod g+rwx "$HOME/.docker" -R
```

Exit your terminal and reopen and run command:
```
docker run hello-world
```

**Create a directory and run Git Clone Project**
```
mkdir /opt/monitoring
sudo chown nobody. Monitoring/ -R
cd /opt/monitoring/
git clone https://github.com/renizgo/Monitoring.git
cd Monitoring
```

**Create a network in Docker**
```
docker network create monitoring
```

**Run a Docker Compose**
```
docker-compose up
```




