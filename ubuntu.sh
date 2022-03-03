IP=$(curl -s https://checkip.amazonaws.com)
MYIP="s/xxxxxxxxx/$IP/g";
#update&&upgrade latest package
apt-get update && apt-get -y upgrade
# go to root
cd

# disable ipv6
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local

# install wget and curl
apt-get update;apt-get -y install wget curl;

# set time GMT +7
ln -fs /usr/share/zoneinfo/Asia/Kuala_Lumpur /etc/localtime

# set locale
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config
service ssh restart
# update
apt-get update

# install webserver
apt-get -y install nginx

# install essential package
apt-get -y install nano iptables dnsutils openvpn screen whois ngrep unzip unrar
# install neofetch
apt-get -y install neofetch
echo "clear" >> .bash_profile
echo "neofetch" >> .bash_profile
#install badvpn/udpgw port default is 7300
cd
wget -O /usr/bin/badvpn-udpgw "https://raw.githubusercontent.com/Natch0141/ubuntu/master/badvpn-udpgw64"
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 1000' /etc/rc.local
chmod +x /usr/bin/badvpn-udpgw
screen -dmS updgw badvpn-udpgw --listen-addr 127.0.0.1:7300

# setting port ssh
cd
sed -i '/Port 22/a Port 143' /etc/ssh/sshd_config
sed -i 's/#Port 22/Port  22/g' /etc/ssh/sshd_config
service ssh restart
# install dropbear
apt-get -y install dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=110/g' /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=""/DROPBEAR_EXTRA_ARGS="-p 109 -p 960"/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
service ssh restart && service dropbear restart
# install fail2ban
apt-get -y install fail2ban && service fail2ban restart
#install stunmel
apt-get -y install stunnel4
wget -O /etc/stunnel/stunnel.pem "https://raw.githubusercontent.com/Natch0141/ubuntu/master/stunnel.pem"
wget -O /etc/stunnel/stunnel.conf "https://raw.githubusercontent.com/Natch0141/ubuntu/master/stunnel.conf"
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
service stunnel4 restart
#install squid
cd
apt-get -y install squid
wget -O /etc/squid/squid.conf "https://raw.githubusercontent.com/Natch0141/ubuntu/master/squid.conf"
sed -i $MYIP /etc/squid/squid.conf;
service squid restart
# install webserver
cd
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
wget -O /etc/nginx/nginx.conf "https://raw.githubusercontent.com/Natch0141/ubuntu/master/nginx.conf"
mkdir -p /home/vps/public_html
echo "<pre>SETUP BY DARKNET</pre>" > /home/vps/public_html/index.html
wget -O /etc/nginx/conf.d/vps.conf "https://raw.githubusercontent.com/Natch0141/ubuntu/master/vps.conf"
service nginx restart
#
wget -O /etc/openvpn/openvpn.tar "https://raw.githubusercontent.com/kholizsivoi/script/master/vpn.tar"
cd /etc/openvpn/
tar xf openvpn.tar
rm -f /etc/openvpn/openvpn.tar
wget -O /etc/openvpn/1194.conf "https://raw.githubusercontent.com/kholizsivoi/script/master/1194.conf"
service openvpn restart
sysctl -w net.ipv4.ip_forward=1
sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf
iptables -t nat -I POSTROUTING -s 192.168.100.0/24 -o eth0 -j MASQUERADE
iptables-save > /etc/iptables_set.conf
wget -O /etc/network/if-up.d/iptables "https://raw.githubusercontent.com/kholizsivoi/script/master/iptables"
chmod +x /etc/network/if-up.d/iptables
service openvpn restart

# konfigurasi openvpn
cd /etc/openvpn/
wget -O /etc/openvpn/client.ovpn "https://raw.githubusercontent.com/kholizsivoi/script/master/client-1194.conf"
sed -i $MYIP /etc/openvpn/client.ovpn;
cp client.ovpn /home/vps/public_html/
#install webmin
cd
sed -i '$ a\\ndeb http://download.webmin.com/download/repository sarge contrib' /etc/apt/sources.list
wget http://www.webmin.com/jcameron-key.asc
apt-key add jcameron-key.asc
apt-get update && apt-get -y install webmin
sed -i -e 's/ssl=1/ssl=0/g' /etc/webmin/miniserv.conf
service webmin restart
#download
cd /usr/bin
wget -O menu "https://raw.githubusercontent.com/Natch0141/ubuntu/master/menu.sh"
wget -O user-add "https://raw.githubusercontent.com/Natch0141/ubuntu/master/user-add.sh"
wget -O user-del "https://raw.githubusercontent.com/Natch0141/ubuntu/master/user-del.sh"
wget -O user-list "https://raw.githubusercontent.com/Natch0141/ubuntu/master/user-list.sh"
wget -O user-log "https://raw.githubusercontent.com/Natch0141/ubuntu/master/user-log.sh"
wget -O speedtest "https://raw.githubusercontent.com/Natch0141/ubuntu/master/speedtest.py"
wget -O resvis "https://raw.githubusercontent.com/Natch0141/ubuntu/master/resvis.sh"
echo "0 0 * * * root /sbin/reboot" > /etc/cron.d/reboot
#
chmod +x menu
chmod +x user-add
chmod +x user-del
chmod +x user-list
chmod +x user-log
chmod +x speedtest
chmod +x resvis
#
service cron restart
service ssh restart
service dropbear restart
service squid restart
service fail2ban restart
service webmin restart
rm -rf ~/.bash_history && history -c
echo "unset HISTFILE" >> /etc/profile
clear
#success
echo "behasil"
rm -f /root/ubuntu.sh
menu
