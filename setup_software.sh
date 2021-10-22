#!/bin/bash

echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections;
#For python
sudo apt-get update -y;
sudo apt-get install -y software-properties-common;
sudo apt-get update;
sudo apt-get install -y python;
sudo apt-get install -y python-virtualenv;
sudo apt-get install -y build-essential;

#Install lsb utilities
sudo apt install -y lsb-core;

#Install terminator
sudo apt-get install -y terminator;

#Install Monodevelop
sudo apt update;
sudo apt install -y apt-transport-https dirmngr \
  && sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \ 
  && echo "deb https://download.mono-project.com/repo/ubuntu vs-bionic main" | sudo tee /etc/apt/sources.list.d/mono-official-vs.list \
  && sudo apt update \
  && sudo apt install -y monodevelop \
  && sudo rm -rf /var/lib/apt/lists/*;

wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin;
sudo mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600;
wget https://developer.download.nvidia.com/compute/cuda/11.2.0/local_installers/cuda-repo-ubuntu2004-11-2-local_11.2.0-460.27.04-1_amd64.deb;
sudo dpkg -i cuda-repo-ubuntu2004-11-2-local_11.2.0-460.27.04-1_amd64.deb;
sudo apt-key add /var/cuda-repo-ubuntu2004-11-2-local/7fa2af80.pub;
sudo apt-get update -y;
sudo apt-get -y install cuda;


echo 'export PATH="/usr/local/cuda/bin:$PATH"' >> /home/admin/.bashrc;
echo 'export LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"' >> /home/admin/.bashrc;

