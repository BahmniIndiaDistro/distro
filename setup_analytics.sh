#!/bin/bash
set -e

if [ ! -f /tmp/app.properties ]; then
    echo "Please setup /tmp/app.properties!"
    echo "More info here https://github.com/BahmniIndiaDistro/distro#install-the-bahmni-analytics-app"
    exit 1
fi
echo "***************"
echo "Install Epel-Release, R and other utilities"
rpm -qa | grep -q epel-release || rpm -Uvh http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
yum install -y openssh-server openssh-clients tar wget yum-plugin-ovl R libcurl libcurl-devel openssl-devel mysql-devel libjpeg-turbo-devel libpng-devel postgresql-devel ; yum clean all
echo "Done"
echo "***************"
echo "Install Shiny-Server"
wget https://download3.rstudio.org/centos5.9/x86_64/shiny-server-1.5.3.838-rh5-x86_64.rpm
rpm -qa | grep -qw shiny-server || yum install -y --nogpgcheck shiny-server-1.5.3.838-rh5-x86_64.rpm
echo "Done"
echo "***************"
echo "Remove Sample Apps and setup bahmni-shiny"
rm -rf /srv/shiny-server/*
cd /srv/shiny-server/
wget https://github.com/ICT4H/bahmni-shiny/archive/master.zip
unzip master.zip
mv bahmni-shiny-master bahmni-shiny
mv -f /tmp/app.properties bahmni-shiny/
chown shiny:shiny -R bahmni-shiny
rm -f master.zip
cd /srv/shiny-server/bahmni-shiny
echo "Install dependency packages for bahmni_shiny. It is time consuming"
R -f install_packages.R
echo "***************"
echo "Done"
echo "Replace shiny library with specific version"
cd /usr/lib64/R/library/
rm -rf shiny
wget https://github.com/ICT4H/bahmni-shiny/raw/master/bin/shiny.zip
unzip shiny.zip
rm -f shiny.zip
echo "Done"
echo "***************"
echo "Configure Shiny Server"
mv /etc/shiny-server/shiny-server.conf /etc/shiny-server/shiny-server.conf.bkp
cd /srv/shiny-server/bahmni-shiny
mv setup/shiny-server.conf /etc/shiny-server/shiny-server.conf
/sbin/iptables -I INPUT 1 -p tcp --dport  3838 -j ACCEPT -m comment --comment "Analytics App"
service iptables save
echo "Done"
echo "***************"
echo "Create Necessary Folder Structure, sqlite database and create demo user"
cd /var/lib/ && mkdir bahmni-shiny && cd bahmni-shiny
mkdir preferences && mkdir plugins
touch shiny.sqlite
sqlite3 shiny.sqlite 'create table users(username varchar primary key, password varchar);'
sqlite3 shiny.sqlite "insert into users values('demo','\$2a\$12\$aZyMtR.kaSqrpK2h/ID43utwz8bS6g.aovQW9z0/kvhlcnwYPfsfe');"
restart shiny-server
echo "Done"
echo "***************"
echo "Create General Analytics plugin"
mv /srv/shiny-server/bahmni-shiny/plugins/1-General/ /var/lib/bahmni-shiny/plugins/
echo "Done"
echo "***************"