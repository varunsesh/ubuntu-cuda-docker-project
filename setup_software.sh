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
sudo apt install git;

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

sudo snap install cmake --classic;
sudo snap install blender --classic;
sudo snap install code --classic;
mkdir projects;
git clone https://varunsesh@bitbucket.org/mimyk/endomimyk_v1.x.git /home/endomimyk/projects/;
git submodule update --init --recursive;

wget 'https://public.sn.files.1drv.com/y4mKCMs636K4qojyJIIQasip8Hpo-0e5A2GaegZE-gev9ylUHOed7N6FPmxgYI-l5WOw0-BPdcp6qRcBu4oVQX2t7BnoHDy9tx8O56ffjed73onmIbmGbmy7Izbl2efoFm5-i0JcUZwgf_pTjBIwnwc9cVPlfqVsQMagAPG4n8GLR_gODrBZSjlZltlraNHREn_I_Nvryg-3O9A3Chl-zbmZ4sSX9ZBcZWMdUk2VSGYL84?access_token=EwAQA61DBAAU2kADSankulnKv2PwDjfenppNXFIAAY0lO3lknHWbl7XUP%2bPCCugFjKKXSd4Dy9/ObywlqGI6XOAPDNYkABvAOsHYKnoyx3ACexbUQrgWmPUba7odgSWwBi3Gd6bgdWOKvMbSjBpIePvkap6Bz8gmhZrBuv2StZBQ7I5AXHAccUqCOPeoqRhsX/UU3pJKT9hs8lHekvd5kr4KwurNRRuT2x4C1gekjkK0qAKlCBlDjFvcyPs/Hn9MWfgETijCemgEnu069/qIGSA8l4bwsdNw4oicI7ZdUOuHr2l4ie1/Nx8GQmFuuOIGT2LzKVQdXVkJT%2bNeS99K0mLAr3Jtm/C24sZeRDJdgJmJOxU2LquIIM3gL2EJQqMDZgAACJ60B/m/rVyj4AFFFjuUC8lGAN4%2bR0YmUkbrW6KBlXUo2PVLK589CAfabjJJR2Yljq6O/Rv5igWqJ3oREa8NkH5VGXu7QMO5UmBLFUqNNDlbO8bagzGAJu1Aml8N9z/0NJ8dUw7AqM%2bgihN/QP3BZ7XBM5QWdOKQnpG5dI6BO/KBLD8IazxnyhaDPrtdVW2B2vpV2dyXmUTJLBhDqeXVkGvWvrNLKiwiQiAkXq631x8YDK0bpducNwQ8uqoHU8IczoqzHuJNwsklaTBGct5pJAous33vjfwnIxW48rUvoI3WFaS5tfJvgfcZROYPy/jtvVhmojxUE6xpoW6mDSXGpI%2bZhOxQ9WVQYkD/U7qUy/3NpNjjkMXzzqfGslMbNRJrBUlhD498CqL8D725kgNEczoxaQ1yAtFVEMyv34ThXL0W/sYq%2beNkKsY05QSU3EmYyps18c/LItxw12Oc%2bzxcAKCEGK%2buYszVHfbd82Sy3jLnw6ZonVd9DkV2xXsUxhxZjDhXk6CwWRNrDO%2bBlIDJ/HECQG3aOLUF5Jd568te6kwDd4L5ofQuI02awm6qS7U2cTkHyoQooxSSl8b8v%2bmdDTsYHjKWYIF4Y7oeZR/CdnwCx9jN0NNds0wmImTPe1reD2Fi84vvW0ViDLYUAg%3d%3d'   -H 'authority: public.sn.files.1drv.com'   -H 'sec-ch-ua: ";Not A Brand";v="99", "Chromium";v="94"'   -H 'sec-ch-ua-mobile: ?0'   -H 'sec-ch-ua-platform: "Linux"'   -H 'upgrade-insecure-requests: 1'   -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36'   -H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9'   -H 'sec-fetch-site: cross-site'   -H 'sec-fetch-mode: navigate'   -H 'sec-fetch-dest: iframe'   -H 'referer: https://onedrive.live.com/'   -H 'accept-language: en-GB,en-US;q=0.9,en;q=0.8'   -H 'cookie: ANON=; NAP=; WLSRDSecAuth=FABiARQL3KgEDBNbW84gMYrDN0fBab7xkQNmAAAEgAAACBAvfRpm5JwkIAGWmvA888RJGcFYs/zt7wAp6/aEmFODzptGSUbbekS6H/7jhTvZkyWiduGK/jVyIoXpdbk1WyQBd8AeGjHwSPztlcbmD9Dz2pCJFsmHH/ZBgjhUAynlPlOCUYTf/e/MYsHjbsvn67vKhrX031dvEIWfQATMhylstnilSpTbZzzrA13BjZdHODvLnEZzURWybBvGJxcVFi9s72fbDHk8RfV42ObChfY2z7PBYFlNHE0yvOc5jnuc2scm2%2BmCUEOjlr11fJDHZDZg6IeYE0MTfvBi1zCUuRaKCxNDDZqeQpiUaub4d5RBtlkOI54eYIco%2BmLTR79fS8R2IsERNkQdLfcki6BVhepzqH%2BBR9ixcHilWGS8gUOdkmNHUsc5hfMJBCAUAK3yzMUDvb5qq/nZy4CQd%2BZhJxjq';
mv y4mKCMs636K4qojyJIIQasip8Hpo-0e5A2GaegZE-gev9ylUHOed7N6FPmxgYI-l5WOw0-BPdcp6qRcBu4oVQX2t7BnoHDy9tx8O56ffjed73onmIbmGbmy7Izbl2efoFm5-i0JcUZwgf_pTjBIwnwc9cVPlfqVsQMagAPG4n8GLR_gODrBZSjlZltlraNHREn_I_Nvryg-3O9A3Chl-zbmZ4sSX9ZBcZWMdUk2VSGYL dvc.deb;

sudo dpkg -i dvc.deb;




