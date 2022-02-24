#!/bin/bash
# Script by Darknet

systemctl stop v2ray.service
systemctl stop v2ray@none.service
systemctl stop v2ray@vless.service
systemctl stop v2ray@vnone.service
systemctl stop trojan.service
systemctl stop xray-mini@vless-direct.service

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

sudo apt install software-properties-common -y

sudo add-apt-repository ppa:certbot/certbot

sudo apt-get install certbot -y

systemctl stop v2ray.service
systemctl stop v2ray@none.service
systemctl stop v2ray@vless.service
systemctl stop v2ray@vnone.service
systemctl stop trojan.service
systemctl stop xray-mini@vless-direct.service

rm -rf /etc/v2ray/v2ray.crt
rm -rf /etc/v2ray/v2ray.key

sudo certbot certonly --standalone --preferred-challenges http --agree-tos --email $email -d $host

sudo ln -s /etc/letsencrypt/live/*/fullchain.pem /etc/v2ray/v2ray.crt
sudo ln -s /etc/letsencrypt/live/*/privkey.pem /etc/v2ray/v2ray.key

rm -rf /etc/apt/sources.list.d/certbot-ubuntu-certbot-jammy.list
rm -rf /var/lib/patch-domain/newdomain.conf
rm -rf /var/lib/patch-email/email.conf
rm -rf /root/email
rm -rf /root/domainku
rm -rf patchssl.sh


