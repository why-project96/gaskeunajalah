#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- icanhazip.com);
echo "Script By whyvpn1"
clear
if [[ "$IP2" = "" ]]; then
domain=$(cat /etc/v2ray/domain)
else
domain=$IP2
fi
read -p "Username : " Login
read -p "Password : " Pass
read -p "Expired (hari): " masaaktif

IP=$(wget -qO- icanhazip.com);
ssl="$(cat ~/log-install.txt | grep -w "Stunnel4" | cut -d: -f2)"
multi="$(cat ~/log-install.txt | grep -w "SSH Multiplexer" | cut -d: -f2)"
sqd="$(cat ~/log-install.txt | grep -w "Squid" | cut -d: -f2)"
ovpn="$(netstat -nlpt | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
ovpn2="$(netstat -nlpu | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
sleep 1
echo Ping Host
echo Cek Hak Akses...
sleep 0.5
echo Permission Accepted
clear
sleep 0.5
echo Membuat Akun: $Login
sleep 0.5
echo Setting Password: $Pass
sleep 0.5
clear
useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $Login
exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
created=`date -d "0 days" +"%d-%m-%Y"`
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
echo -e ""
echo -e "==============================="
echo -e "Informasi SSH & OpenVPN"
echo -e "==============================="
echo -e "IP/Host     : $IP"
echo -e "Domain      : ${domain}"
echo -e "Username    : $Login "
echo -e "Password    : $Pass"
echo -e "==============================="
echo -e "OpenSSH     : $multi, 22"
echo -e "Dropbear    : $multi, 109, 143"
echo -e "Ws None TLS : 2095"
echo -e "Ws OVPN     : 2082"
echo -e "Ws TLS      : $multi"
echo -e "SSL/TLS     : $multi, 222, 777"
echo -e "Port Squid  : 3128, 8080"
echo -e "Port TCP    : 1194"
echo -e "Port UDP    : 2200"
echo -e "Port SSL    : 442"
echo -e "BadVpn      : 7100-7300"
echo -e "==============================="
echo -e "PAYLOAD WS NONTLS  :"
echo -e "GET / HTTP/1.1[crlf]Host: ${domain}[crlf]Upgrade: websocket[crlf][crlf]"
echo -e "==============================="
echo -e "==============================="
echo -e "PAYLOAD WS SSL/TLS  :"
echo -e "GET wss://bug.com [protocol][crlf]Host: ${domain}[crlf]Upgrade: websocket[crlf][crlf]"
echo -e ""
echo -e "PROXY DI ISI : Bug.com:443"
echo -e "SNI/SSL DI ISI : Bug.com"
echo -e "==============================="
echo -e "Link Download Ovpn"
echo -e "==============================="
echo -e "http://$IP:81/client-tcp-$ovpn.ovpn"
echo -e "http://$IP:81/client-udp-$ovpn2.ovpn"
echo -e "http://$IP:81/client-tcp-ssl.ovpn"
echo -e ""
echo -e "==============================="
echo -e "Created  : $created"
echo -e "Expired   : $exp"
echo -e "==============================="
echo -e ""
echo -e "Script By whyvpn1"
echo -e ""
