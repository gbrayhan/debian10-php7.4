FROM debian:buster
# docker image gbrayhan/debian10-php7.4:v1.0
MAINTAINER Alejandro Guerrero (gbrayhan@gmail.com)

RUN apt-get update && apt-get upgrade -y --no-install-recommends ; \
apt-get install -y gnupg2 -y ; \
apt install ca-certificates apt-transport-https wget unzip zip curl -y ; \
wget -q https://packages.sury.org/php/apt.gpg -O- | apt-key add - ; \
echo "deb https://packages.sury.org/php/ stretch main" | tee /etc/apt/sources.list.d/php.list ;  \
apt update -y && apt install php7.4 -y && apt install -y php7.4-cli php7.4-common php7.4-curl php7.4-zip php7.4-mbstring php7.4-mysql php7.4-xml php7.4-soap php7.4-gd php7.4-bcmath php7.4-amqp php7.4-mongodb ; \
mkdir /srv/app && chmod 755 /srv -R  ; \
echo "<VirtualHost *:80> \n  ServerName localhost \n  ServerAdmin admin@app.com \n  DocumentRoot /srv/app \n  \n  ErrorLog /var/log/apache2/app-error.log \n  CustomLog /var/log/apache2/app-access.log combined \n  \n  <Directory /srv/app/> \n    Options -Indexes +FollowSymLinks +MultiViews \n    AllowOverride All \n    Require all granted \n  </Directory> \n  \n</VirtualHost> " > /etc/apache2/sites-available/000-default.conf ; \
a2enmod rewrite && \
LINE='ServerName localhost' ;\
FILE='/etc/apache2/apache2.conf' ; \
grep -qF -- "$LINE" "$FILE" || echo "$LINE" >> "$FILE" ;
