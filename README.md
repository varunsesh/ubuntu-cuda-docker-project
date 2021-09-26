# Ubuntu-Cuda-Docker-Project
## Introduction
This project aims to create a docker image of Ubuntu 20.04 with all the necessary software and drivers required for high performance computing. The following is the software spec of the container:
1. Ubuntu 20.04
2. Cuda 11.4 
The docker image uses the nvidia-container as the base image. The drawback of this approach is the docker container exposes the driver installed on the base/host machine to the docker container. The result being that the correct driver version for the cuda toolkit must be installed on the base/host machine before using the toolkit in the container.



## Docker Installation
1. Before installing docker, first setup the repository using
```
    $ sudo apt-get update \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg \
        lsb-release
    
    $ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    $  echo \
            "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
            $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    $ sudo apt-get update
    $ sudo apt-get install docker-ce docker-ce-cli containerd.io
```
2. To run docker without being root:
    $ sudo usermod -aG docker $USER


## Using the docker file
1. Once docker is successfully installed first build the docker image.
```   
    $ ./build-docker-image.bash
```
This will take a few moments to complete. 

2. Once the image is built launch the container:
```   
    $ ./run-docker-container.bash
```
## Notes
1. The default username in the docker container is admin and has all sudo privelages. No password is required for sudo commands.


## TO DO
1. Snap store isn't available in a docker environment. There are workarounds but they have not been implemented at this point. 
2. Burning the entire docker image to a bootable disk.

