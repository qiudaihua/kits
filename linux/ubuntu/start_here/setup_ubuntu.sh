#!/bin/bash

current_time=`date +"%Y%m%d-%H-%M-%S"` #date +"%Y%m%d-%H-%M-%S"
sudo cp /etc/apt/sources.list /etc/apt/sources.list.${current_time}
sudo cp ../source_list/14.04/sources.list /etc/apt/sources.list
sudo apt-get update
sudo apt-get upgrade

sudo apt-get install gnome-session-fallback gconf-editor
sudo apt-get install TypeCatcher
sudo apt-get install adobe-flashplugin*
sudo apt-get install iptux
sudo apt-get install jedit p7zip*

sudo apt-get install virtualbox*
sudo adduser daiq vboxusers

sudo add-apt-repository ppa:wiznote-team
sudo apt-get update
sudo apt-get install wiznote

nslookup googlesource.com
nslookup android.googlesource.com
sudo chmod a+w /etc/hosts
sudo echo "74.125.20.82 googlesource.com" >> /etc/hosts
sudo echo "74.125.20.82 android.googlesource.com" >> /etc/hosts

sysctl -w net.ipv4.tcp_window_scaling=0
repo sync -j1


