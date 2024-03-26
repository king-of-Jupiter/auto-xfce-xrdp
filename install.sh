#!/bin/sh
sudo apt -y remove needrestart
sudo useradd -m sammy
echo "sammy:sammy" | sudo chpasswd
sudo usermod -aG sudo sammy
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo apt update && apt upgrade -y
sudo apt-get install xfce4 xfce4-goodies xorg dbus-x11 x11-xserver-utils google-chrome-stable -y
sudo apt install xrdp xorgxrdp -y && sudo systemctl enable xrdp
sudo adduser xrdp ssl-cert
cd /etc/xrdp
sudo mv startwm.sh startwm.sh.bak
sudo echo '#!/bin/sh' > /etc/xrdp/startwm.sh
sudo echo 'if [ -r /etc/default/locale ]; then' >> /etc/xrdp/startwm.sh
sudo echo '. /etc/default/locale' >> /etc/xrdp/startwm.sh
sudo echo 'export LANG LANGUAGE' >> /etc/xrdp/startwm.sh
sudo echo 'fi' >> /etc/xrdp/startwm.sh
sudo echo 'exec /usr/bin/startxfce4' >> /etc/xrdp/startwm.sh
sudo chmod 755 startwm.sh
sudo systemctl restart xrdp
sudo cat << E0F > /etc/polkit-1/localauthority/50-local.d/45-allow.colord.pkla

[Allow Colord all Users]

Identity=unix-user:*

Action=org.freedesktop.color-manager.create-device;org.freedesktop.color-manager.create-profile;org.freedesktop.color-manager.delete-device;org.freedesktop.color-manager.delete-profile;org.freedesktop.color-manager.modify-device;org.freedesktop.color-manager.modify-profile

ResultAny=no

ResultInactive=no

ResultActive=yes

E0F

