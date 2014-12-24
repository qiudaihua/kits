#!/bin/bash

current_time=`date +"%Y%m%d-%H-%M-%S"` #date +"%Y%m%d-%H-%M-%S"
sudo cp /etc/apt/sources.list /etc/apt/sources.list.${current_time}
sudo cp ../source_list/14.04/sources.list /etc/apt/sources.list
sudo apt-get update
sudo apt-get upgrade

#sudo apt-get install ia32-libs
sudo apt-get install lib32ncurses5
#lib32z1 lib32ncurses5 lib32bz2-1.0

sudo apt-get install gnome-session-fallback gconf-editor
sudo apt-get install gnome-tweak-tool
sudo apt-get install TypeCatcher

sudo apt-get install dconf-editor
org - gnome -desktop - interface，gtk-color-scheme 

写的格式是：
项目名称：颜色名称；项目名称：颜色名称；
项目名称要在这里找
http://live.gnome.org/GnomeArt/Tutorial ... olicColors

比如我是这么写的：base_color:#FAF9DE;selected_fg_color:#D3D3D3;selected_bg_color:#008522
fg_color The base for the foreground colors.  
bg_color Color to generate the background colors from.  
base_color The base color.  
text_color The text color in input widgets.  
selected_bg_color Color for the background of selected text.  
selected_fg_color Color of selected text.  
tooltip_bg_color Background color of tooltips.  
tooltip_fg_color Text color for text in tooltips.  
 
我这里设置是这样的
base_color:#CCE8CF

sudo apt-get install adobe-flashplugin*
sudo apt-get install iptux
sudo apt-get install jedit p7zip*

sudo apt-get install virtualbox*
sudo adduser daiq vboxusers

sudo add-apt-repository ppa:wiznote-team
sudo apt-get update
sudo apt-get install wiznote

#12.04
sudo ls /etc/lightdm/*.conf
sudo echo "allow-guest=false" >> /etc/lightdm/lightdm.conf
#14.04
sudo sh -c 'echo "allow-guest=false" >> /usr/share/lightdm/lightdm.conf.d/50-ubuntu.conf'
sudo service lightdm restart

nslookup googlesource.com
nslookup android.googlesource.com
sudo chmod a+w /etc/hosts
sudo echo "74.125.20.82 googlesource.com" >> /etc/hosts
sudo echo "74.125.20.82 android.googlesource.com" >> /etc/hosts

sysctl -w net.ipv4.tcp_window_scaling=0
repo sync -j1


