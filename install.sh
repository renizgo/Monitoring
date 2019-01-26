#!/bin/bash

echo "Changing Localhost for IP Server in nginx.conf file"
IP=`ifconfig | grep -A2 enp | grep -v inet6 | grep inet | awk '{print $2}'`
sed -i -e "s/localhost/$IP/" nginx-config/nginx.conf

# Verifying instalation of Git
git version > /dev/null
echo "----------"
if [ $? -eq 0 ]; then
  echo "Git OK"
  VERSION=`git version`
  echo "Version of Git is: $VERSION"
else
  echo "Installing Git"
  sudo apt install -y git
  VERSION=`git version`
  echo "Git was installed in version: $VERSION"
fi

# Verifying instalation of wget
which wget > /dev/null
echo "----------"
if [ $? -eq 0 ]; then
  echo "Wget OK"
  LOCATE=`which wget`
  echo "Wget is installed in: $LOCATE"
else
  echo "Installing wget"
  sudo apt install -y wget
  LOCATE=`which wget`
  echo "Wget was installed in: $LOCATE"
fi

# Verifying instalation of curl
which curl > /dev/null
echo "----------"
if [ $? -eq 0 ]; then
  echo "Curl OK"
  LOCATE=`which curl`
  echo "Curl is installed in: $LOCATE"
else
  echo "Installing Curl"
  sudo apt install -y wget
  LOCATE=`which curl`
  echo "Curl was installed in: $LOCATE"
fi


# Verifying instalation of Docker
echo "verifying Docker installation, please insert Sudo password"
sudo docker --version 1> /dev/null 2> /dev/stdout
echo "----------"
if [ $? -ne 0 ]; then
  echo "Docker OK"
  echo "Docker is installed in: "
else
  echo "Installing Docker"
  sudo apt-get update -y
  sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
  sudo apt-get update -y
  sudo apt-get install -y docker-ce
  echo "----------"
  sudo docker --version
  echo "----------"
  echo "Above appears docker version? yes or no"
  read YESORNO
  	case $YESORNO in
		yes) 
			echo "Continuing process!";;
		no)
			echo "Please install Docker in your machine!!!"
			exit 1;;
		*)
			echo "Please insert Yes or No";;
	esac
  sudo apt install -y docker-compose
  sudo docker-compose --version
  echo "----------"
  echo "Above appears docker version? Yes or No"
  read YESORNO
  	case $YESORNO in
		yes) 
			echo "Continuing process!";;
		no)
			echo "Please install Docker Compose in your machine!!!"
			exit 1;;
		*)
			echo "Please insert Yes or No";;
	esac
fi

echo "Configuring Docker permission for use Docker without SUDO"

sudo groupadd docker
sudo usermod -aG docker $USER
sudo mkdir /home/"$USER"/.docker
sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
sudo chmod g+rwx "$HOME/.docker" -R

echo "Setting permissions"
sudo find ../Monitoring/ -type d -exec chmod -R 777  "{}" \;
sudo find ../Monitoring/ -type f -exec chmod -R 666  "{}" \;


echo "Create docker networking with monitoring name"

sudo docker network create monitoring

sudo ufw disable

crontab -l 2>/dev/null; echo "@reboot /usr/bin/docker-compose -f /home/$USER/Monitoring/docker-compose.yml  up -d" | crontab -
crontab -l 2>/dev/null; echo "@reboot sudo find /home/$USER/Monitoring/ -type d -exec chmod -R 777  \"{}\" \;" | crontab -
crontab -l 2>/dev/null; echo "@reboot sudo find /home/$USER/Monitoring/ -type f -exec chmod -R 666  \"{}\" \;" | crontab -

echo "Please reboot you server and execute post_install.sh"
echo "Do you wish restart you server?"
  read YESORNO
  	case $YESORNO in
		yes) 
			echo "Rebooting now"
			sudo reboot;;
		no)
			echo "Please reboot before!!!"
			exit 1;;
		*)
			echo "Please insert Yes or No";;
	esac
