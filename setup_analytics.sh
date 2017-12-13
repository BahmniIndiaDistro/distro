#Prerequisite
	#prepate /tmp/app.properties

if [ $# -eq 0 ]
  then
    echo "Usage:- ./setup_analytics.sh <hostname of database>"
    exit 1
fi
echo "***********************************"
echo "Installing epel-relese and docker"
rpm -iUvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
yum update -y 
yum -y install docker-io
echo "***********************************"
echo "Downloading bahmni shiny docker image"
sudo service docker start
docker run --name=shiny -itd -v /tmp/app.properties:/tmp/app.properties  mddubey/bahmni-shiny-v1
echo "***********************************"
echo "Copy app properties file"
docker exec shiny /bin/bash -c "cp /tmp/app.properties /srv/shiny-server/bahmni-shiny/app.properties"
echo "***********************************"
echo "Setting up passwordless ssh for database connection"
docker exec shiny /bin/bash -c "su - shiny -c \"ssh-keyscan $1 >> ~/.ssh/known_hosts\""
docker cp shiny:/home/shiny/.ssh/id_rsa.pub /tmp/
cat /tmp/id_rsa.pub >> /home/bahmni_support/.ssh/authorized_keys
rm -f /tmp/id_rsa.pub
echo "***********************************"
echo "Committing Local image of bahmni shiny and remove the running container"
docker commit shiny shiny-local
docker stop shiny
docker rm shiny
echo "***********************************"
echo "Setting up shared folder for preferences, plugins and users database"
cd /var/lib/ && mkdir bahmni-shiny && cd bahmni-shiny
mkdir preferences && mkdir plugins
touch shiny.sqlite
sqlite3 shiny.sqlite 'create table users(username varchar primary key, password varchar);'
sqlite3 shiny.sqlite "insert into users values('demo','\$2a\$12\$aZyMtR.kaSqrpK2h/ID43utwz8bS6g.aovQW9z0/kvhlcnwYPfsfe');"
echo "***********************************"
echo "Create container with local image and start shiny server"
docker run --name shiny-app -itd -v /var/lib/bahmni-shiny/:/bahmni-shiny/ -p 3838:3838 shiny-local
docker exec shiny-app /bin/bash -c "start-shiny.sh"

