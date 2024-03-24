#!/bin/sh
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
apt update && apt upgrade -y
apt-get install xfce4 xfce4-goodies xorg dbus-x11 x11-xserver-utils google-chrome-stable -y
apt install xrdp -y && systemctl enable xrdp
adduser xrdp ssl-cert
cat << E0F > /etc/polkit-1/localauthority/50-local.d/45-allow.colord.pkla

[Allow Colord all Users]

Identity=unix-user:*

Action=org.freedesktop.color-manager.create-device;org.freedesktop.color-manager.create-profile;org.freedesktop.color-manager.delete-device;org.freedesktop.color-manager.delete-profile;org.freedesktop.color-manager.modify-device;org.freedesktop.color-manager.modify-profile

ResultAny=no

ResultInactive=no

ResultActive=yes

E0F
