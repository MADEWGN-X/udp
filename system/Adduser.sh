#!/bin/bash

#font colors
IP=$(cat /etc/IP)
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
ENDCOLOR="\e[0m"

s_ip=$(wget -qO- https://ipecho.net/plain ; echo)

clear

#add users

echo -e "          ░█▀▀▀█ ░█▀▀▀█ ░█─── ─█▀▀█ ░█▀▀█ 　 ░█▀▀▀█ ░█▀▀▀█ ░█─░█ " | lolcat
echo -e "          ─▀▀▀▄▄ ─▀▀▀▄▄ ░█─── ░█▄▄█ ░█▀▀▄ 　 ─▀▀▀▄▄ ─▀▀▀▄▄ ░█▀▀█ " | lolcat
echo -e "          ░█▄▄▄█ ░█▄▄▄█ ░█▄▄█ ░█─░█ ░█▄▄█ 　 ░█▄▄▄█ ░█▄▄▄█ ░█─░█ " | lolcat
echo ""
echo ""
echo ""

echo -ne "${YELLOW}Enter the username : "; read username
while true; do
    read -p "Do you want to genarate a random password ? (Y/N) " yn
    case $yn in
        [Yy]* ) password=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-9};echo;); break;;
        [Nn]* ) echo -ne "Enter password (please use a strong password) : "; read password; break;;
        * ) echo "Please answer yes or no.";;
    esac
done
echo -ne "Enter No. of Days till expiration : ";read nod
exd=$(date +%F  -d "$nod days")

read -p "Max logins limit: " maxlogins
echo "$username  hard  maxlogins ${maxlogins}" >/etc/security/limits.d/"$username"

useradd -e $exd -M -N -s /bin/false $username && echo "$username:$password" | chpasswd &&
clear &&
echo -e  "${YELLOW} Creating User Please Wait.."
sleep 3
clear
echo -e "          ░█▀▀▀█ ░█▀▀▀█ ░█─── ─█▀▀█ ░█▀▀█ 　 ░█─░█ ░█▀▀▄ ░█▀▀█ " | lolcat
echo -e "          ─▀▀▀▄▄ ─▀▀▀▄▄ ░█─── ░█▄▄█ ░█▀▀▄ 　 ░█─░█ ░█─░█ ░█▄▄█ " | lolcat
echo -e "          ░█▄▄▄█ ░█▄▄▄█ ░█▄▄█ ░█─░█ ░█▄▄█ 　 ─▀▄▄▀ ░█▄▄▀ ░█─── " | lolcat

echo ""
echo ""
echo -e "========== SSH & OVPN Account =========="
echo -e ""
echo -e ""
echo -e "${GREEN}\n• IP Address : ${YELLOW}$s_ip"
echo -e "${GREEN}\n• Username :${YELLOW} $username"
echo -e "${GREEN}\n• Password :${YELLOW} $password"
echo -e "${GREEN}\n• Expire Date :${YELLOW} $exd"
echo -e "${GREEN}\n• Max Login :${YELLOW} $maxlogins${ENDCOLOR}"
#echo -e "======================================="
echo -e ""
#echo -e ""
echo -e "================= Port ================="
echo -e ""
echo -e "${GREEN}\n• Badvpn    : ${YELLOW}1-65535${ENDCOLOR}"
echo -e ""
echo -e "========== Http Custom UDP ==========="
echo -e " "
echo -e "$s_ip:1-65535@$username:$password"
echo -e ""
echo -e "======================================="
echo""
echo -e " >> Contact On Telegram : @shaystudiolab"
echo -e " >> Contact On Github : @noobconner21"
echo""
echo -e "======================================="
#echo -e "${RED}\nFailed to add user $username please try again."
echo ""
echo ""

#return to panel

echo -e "\nPress Enter key to return to main menu"; read
menu
