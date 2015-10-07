#!/bin/bash

cd /

# install server dependencies
sudo apt-get update
sudo apt-get install -y openjdk-7-jre-headless
#sudo apt-get install -y curl

# install build agent dependencies
#sudo apt-get install -y mercurial
sudo apt-get install -y git

# download teamcity
sudo wget -c http://download.jetbrains.com/teamcity/TeamCity-9.1.3.tar.gz -O /tmp/TeamCity-9.1.3.tar.gz

#decompress teamcity
sudo tar -xvf /tmp/TeamCity-9.1.3.tar.gz -C /srv
sudo rm -rf /tmp/TeamCity-9.1.3.tar.gz
sudo mkdir /srv/.BuildServer

# create user
sudo useradd -m teamcity
sudo chown -R teamcity /srv/TeamCity
sudo chown -R teamcity /srv/.BuildServer

# create init.d script
sudo wget https://gist.githubusercontent.com/sandcastle/9282638/raw/teamcity-init.sh -O /etc/init.d/teamcity
sudo chmod 775 /etc/init.d/teamcity
sudo update-rc.d teamcity defaults

# download postgres
sudo mkdir -p /srv/.BuildServer/lib/jdbc
sudo mkdir -p /srv/.BuildServer/config
sudo wget http://jdbc.postgresql.org/download/postgresql-9.3-1101.jdbc41.jar -O /srv/.BuildServer/lib/jdbc/postgresql-9.3-1101.jdbc41.jar
sudo wget https://gist.githubusercontent.com/sandcastle/9282638/raw/postgres.database.properties -O /srv/.BuildServer/config/database.properties

# ensure owership
sudo chown -R teamcity /srv/TeamCity
sudo chown -R teamcity /srv/.BuildServer