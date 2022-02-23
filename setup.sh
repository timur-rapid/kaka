#!/bin/bash
apt-get update
apt-get upgrade -y

 apt install fail2ban -y
 
apt-get install nano wget curl zip unzip tar gzip p7zip-full bc rc openssl cron net-tools dnsutils dos2unix screen bzip2 ccrypt -y

apt-get install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python dbus libxml-parser-perl -y

apt-get install shared-mime-info jq -y

apt-get install -y libxml-parser-perl

apt-get remove --purge ufw firewalld -y

sudo apt install netfilter-persistent -y

wget https://raw.githubusercontent.com/kor8/cyber/beta/ddos.sh && chmod +x ddos.sh && ./ddos.sh && rm -rf ddos.sh

cat > /etc/rc.local <<-END
#!/bin/sh -e
exit 0
END
chmod +x /etc/rc.local
sed -i '$ i\iptables-restore < /etc/iptables.up.rules' /etc/rc.local
echo "nameserver 208.67.222.222" > /etc/resolv.conf
echo "nameserver 208.67.220.220" >> /etc/resolv.conf
sed -i '$ i\echo "nameserver 208.67.222.222" > /etc/resolv.conf' /etc/rc.local
sed -i '$ i\echo "nameserver 208.67.220.220" >> /etc/resolv.conf' /etc/rc.local

sudo apt install squid -y

cat <<'mySquid' > /etc/squid/squid.conf
via off
forwarded_for delete
request_header_access Authorization allow all
request_header_access Proxy-Authorization allow all
request_header_access Cache-Control allow all
request_header_access Content-Length allow all
request_header_access Content-Type allow all
request_header_access Date allow all
request_header_access Host allow all
request_header_access If-Modified-Since allow all
request_header_access Pragma allow all
request_header_access Accept allow all
request_header_access Accept-Charset allow all
request_header_access Accept-Encoding allow all
request_header_access Accept-Language allow all
request_header_access Connection allow all
request_header_access X-Forwarded-For deny all
request_header_access Via deny all
request_header_access Referer deny all
request_header_access All deny all
http_access allow localhost
http_access deny all
cache_peer 127.0.0.1 parent 80 7 no-query no-digest default
cache deny all
mySquid

rm -rf ddos.sh
rm -rf setup.sh
