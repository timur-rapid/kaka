#!/bin/bash
# Script by Darknet

export DEBIAN_FRONTEND=noninteractive
OS=`uname -m`;
MYIP=$(wget -qO- ifconfig.co);
MYIP2="s/xxxxxxxxx/$MYIP/g";
NET=$(ip -o $ANU -4 route show to default | awk '{print $5}');
source /etc/os-release
ver=$VERSION_ID

mkdir /var/lib/patch-domain;
echo -e "${green}ENTER THE VPS SUBDOMAIN/HOSTNAME, PLEASE CLICK ENTER${NC}"
read -p "Hostname / Domain: " host
echo "IP=$host" >> /var/lib/patch-domain/newdomain.conf
echo "$host" >> /root/domainku

mkdir /var/lib/patch-email;
echo -e "${green}ENTER THE VPS DOMAIN EMAIL N PRESS ENTER${NC}"
read -p "Email / Gmail: " email
echo "IP=$email" >> /var/lib/patch-email/email.conf
echo "$email" >> /root/email

sudo apt install software-properties-common

sudo apt-get install certbot

sudo certbot certonly --standalone --preferred-challenges http --agree-tos --email $email -d $host

sudo mv /etc/letsencrypt/live/$host/fullchain.pem /etc/v2ray/v2ray.crt

sudo mv /etc/letsencrypt/live/$host/fullchain.pem /etc/v2ray/v2ray.key


