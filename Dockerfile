FROM ubuntu:20.04 as base


ENV NV_CUDA_LIB_VERSION "11.4.2-1"

FROM base as base-amd64

ENV NV_CUDA_CUDART_DEV_VERSION 11.4.108-1
ENV NV_NVML_DEV_VERSION 11.4.120-1
ENV NV_LIBCUSPARSE_DEV_VERSION 11.6.0.120-1
ENV NV_LIBNPP_DEV_VERSION 11.4.0.110-1
ENV NV_LIBNPP_DEV_PACKAGE libnpp-dev-11-4=${NV_LIBNPP_DEV_VERSION}

ENV NV_LIBCUBLAS_DEV_VERSION 11.6.1.51-1
ENV NV_LIBCUBLAS_DEV_PACKAGE_NAME libcublas-dev-11-4
ENV NV_LIBCUBLAS_DEV_PACKAGE ${NV_LIBCUBLAS_DEV_PACKAGE_NAME}=${NV_LIBCUBLAS_DEV_VERSION}

ENV NV_LIBNCCL_DEV_PACKAGE_NAME libnccl-dev
ENV NV_LIBNCCL_DEV_PACKAGE_VERSION 2.11.4-1
ENV NCCL_VERSION 2.11.4-1
ENV NV_LIBNCCL_DEV_PACKAGE ${NV_LIBNCCL_DEV_PACKAGE_NAME}=${NV_LIBNCCL_DEV_PACKAGE_VERSION}+cuda11.4

FROM base as base-arm64

ENV NV_CUDA_CUDART_DEV_VERSION 11.4.108-1
ENV NV_NVML_DEV_VERSION 11.4.120-1
ENV NV_LIBCUSPARSE_DEV_VERSION 11.6.0.120-1
ENV NV_LIBNPP_DEV_VERSION 11.4.0.110-1
ENV NV_LIBNPP_DEV_PACKAGE libnpp-dev-11-4=${NV_LIBNPP_DEV_VERSION}

ENV NV_LIBCUBLAS_DEV_PACKAGE_NAME libcublas-dev-11-4
ENV NV_LIBCUBLAS_DEV_VERSION 11.6.1.51-1
ENV NV_LIBCUBLAS_DEV_PACKAGE ${NV_LIBCUBLAS_DEV_PACKAGE_NAME}=${NV_LIBCUBLAS_DEV_VERSION}

ENV NV_LIBNCCL_DEV_PACKAGE_NAME libnccl-dev
ENV NV_LIBNCCL_DEV_PACKAGE_VERSION 2.11.4-1
ENV NCCL_VERSION 2.11.4-1
ENV NV_LIBNCCL_DEV_PACKAGE ${NV_LIBNCCL_DEV_PACKAGE_NAME}=${NV_LIBNCCL_DEV_PACKAGE_VERSION}+cuda11.4


LABEL maintainer "NVIDIA CORPORATION <cudatools@nvidia.com>"


RUN apt-get update && \
    apt-get -y install sudo && \
    rm -rf /var/lib/apt/lists/*
    
RUN adduser --disabled-password --gecos '' admin
RUN adduser admin sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER admin
##Setting up the tzdata
ENV TZ=Asia/Kolkata
RUN sudo ln -snf /usr/share/zoneinfo/$TZ /etc/localtime 
RUN sudo touch /etc/timezone
RUN sudo chmod 777 /etc/timezone
RUN sudo echo $TZ > /etc/timezone
RUN sudo apt update
RUN sudo apt install -y tzdata
RUN sudo rm -rf /var/lib/apt/lists/*

RUN sudo apt-get update && sudo apt-get install -y gnupg2

RUN sudo apt-key adv --fetch-keys  http://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub
RUN sudo bash -c 'echo "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64 /" > /etc/apt/sources.list.d/cuda.list'
RUN sudo apt update


RUN sudo apt-get update && sudo apt-get install -y --no-install-recommends \
    libtinfo5 libncursesw5 \
    cuda-cudart-dev-11-4=${NV_CUDA_CUDART_DEV_VERSION} \
    cuda-command-line-tools-11-4=${NV_CUDA_LIB_VERSION} \
    cuda-minimal-build-11-4=${NV_CUDA_LIB_VERSION} \
    cuda-libraries-dev-11-4=${NV_CUDA_LIB_VERSION} \
    cuda-nvml-dev-11-4=${NV_NVML_DEV_VERSION} \
    ${NV_LIBNPP_DEV_PACKAGE} \
    libcusparse-dev-11-4=${NV_LIBCUSPARSE_DEV_VERSION} \
    ${NV_LIBCUBLAS_DEV_PACKAGE} \
    ${NV_LIBNCCL_DEV_PACKAGE} \
    && sudo rm -rf /var/lib/apt/lists/*

# Keep apt from auto upgrading the cublas and nccl packages. See https://gitlab.com/nvidia/container-images/cuda/-/issues/88
RUN sudo apt-mark hold ${NV_LIBCUBLAS_DEV_PACKAGE_NAME} ${NV_LIBNCCL_DEV_PACKAGE_NAME}

ENV LIBRARY_PATH /usr/local/cuda/lib64/stubs


RUN sudo apt update -y
RUN sudo apt-get install -y ca-certificates-mono


#Install wget
RUN  sudo apt-get update \
  && sudo apt-get install -y wget \
  && sudo rm -rf /var/lib/apt/lists/*

# get unity-hub
RUN sudo mkdir -p /opt/unity 
RUN sudo chmod 777 /opt/unity
RUN wget -P /opt/unity https://public-cdn.cloud.unity3d.com/hub/prod/UnityHub.AppImage 
RUN chmod +x /opt/unity/UnityHub.AppImage


##Setup the keyboard properties
RUN file='/etc/default/keyboard'
RUN sudo touch /etc/default/keyboard
RUN sudo chmod 777 /etc/default/keyboard
RUN sudo echo '# KEYBOARD CONFIGURATION FILE' >> /etc/default/keyboard
RUN sudo echo '# Consult the keyboard(5) manual page.' >> /etc/default/keyboard
RUN sudo echo 'XKBMODEL="pc105"' >> /etc/default/keyboard
RUN sudo echo 'XKBLAYOUT="us"' >> /etc/default/keyboard
RUN sudo echo 'XKBVARIANT=""' >> /etc/default/keyboard
RUN sudo echo 'XKBOPTIONS=""' >> /etc/default/keyboard
RUN sudo echo 'BACKSPACE="guess"' >> /etc/default/keyboard


RUN echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections
#For python
RUN sudo apt-get update -y
RUN sudo apt-get install -y software-properties-common
RUN sudo add-apt-repository ppa:deadsnakes/ppa
RUN sudo apt-get update
RUN sudo apt-get install -y python3.8

#Install lsb utilities
RUN sudo apt install -y lsb-core

#Install terminator
RUN sudo apt-get install -y terminator

#Install Monodevelop
RUN sudo apt update
RUN sudo apt install -y apt-transport-https dirmngr \
  && sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \ 
  && echo "deb https://download.mono-project.com/repo/ubuntu vs-bionic main" | sudo tee /etc/apt/sources.list.d/mono-official-vs.list \
  && sudo apt update \
  && sudo apt install -y monodevelop \
  && sudo rm -rf /var/lib/apt/lists/*


## Getting the latest nvidia driver
RUN mkdir /home/admin/nvidia-driver
RUN wget -P /home/admin/nvidia-driver https://us.download.nvidia.com/XFree86/Linux-x86_64/470.74/NVIDIA-Linux-x86_64-470.74.run
RUN chmod +x /home/admin/nvidia-driver/NVIDIA-Linux-x86_64-470.74.run

##Installing Nvidia driver from apt
# RUN sudo apt update -y
# RUN sudo apt install nvidia-driver-470 -y
##This causes nvidia-smi to not function properly. Might still do the trick


RUN echo 'export PATH="/usr/local/cuda/bin:$PATH"' >> /home/admin/.bashrc
RUN echo 'export LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"' >> /home/admin/.bashrc

##Install tar
RUN sudo apt update -y
RUN sudo apt install tar -y
##Install CMake
RUN mkdir /home/admin/cmake
RUN wget -P /home/admin/cmake https://github.com/Kitware/CMake/releases/download/v3.21.3/cmake-3.21.3-linux-x86_64.tar.gz


# Make SSH available
EXPOSE 22

##App Images require fuse to run
RUN sudo apt update -y
RUN sudo apt-get install -y fuse
RUN sudo addgroup fuse

##Install git
RUN sudo apt update -y
RUN sudo apt install -y git

CMD /bin/bash