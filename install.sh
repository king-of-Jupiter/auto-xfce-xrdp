#!/bin/sh
sudo apt -y remove needrestart
sudo useradd -m sammy
echo "sammy:sammy" | sudo chpasswd
sudo usermod -aG sudo sammy
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo apt update && apt upgrade -y
sudo apt-get install xfce4 xfce4-goodies xorg dbus-x11 x11-xserver-utils google-chrome-stable -y
sudo apt install xrdp -y && systemctl enable xrdp
sudo adduser xrdp ssl-cert
sudo cat << E0F > /etc/polkit-1/localauthority/50-local.d/45-allow.colord.pkla

[Allow Colord all Users]

Identity=unix-user:*

Action=org.freedesktop.color-manager.create-device;org.freedesktop.color-manager.create-profile;org.freedesktop.color-manager.delete-device;org.freedesktop.color-manager.delete-profile;org.freedesktop.color-manager.modify-device;org.freedesktop.color-manager.modify-profile

ResultAny=no

ResultInactive=no

ResultActive=yes

E0F

desktop_file="/home/sammy/Desktop/google-chrome.desktop"

cat <<EOT > $desktop_file
[Desktop Entry]
Version=1.0
Name=Google Chrome
Exec=/usr/bin/google-chrome-stable %U
StartupNotify=true
Terminal=false
Icon=google-chrome
Type=Application
Categories=Network;WebBrowser;
MimeType=application/pdf;application/rdf+xml;application/rss+xml;application/xhtml+xml;application/xhtml_xml;application/xml;image/gif;image/jpeg;image/png;image/webp;text/html;text/xml;x-scheme-handler/http;x-scheme-handler/https;
Actions=new-window;new-private-window;
EOT

chmod 755 $desktop_file
