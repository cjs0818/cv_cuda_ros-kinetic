#--------------------
# For CUDA
#FROM jschoi/yolo
#FROM nvidia/cuda
#FROM jschoi/cv_cuda
#FROM jschoi/cv_cuda_ros-kinetic:core
FROM jschoi/cv_cuda_ros-kinetic:base
#--------------------

#-------------------
#  RoS

# install ros packages
RUN apt-get update && apt-get install -y \
    ros-kinetic-robot=1.3.1-0* \
    && rm -rf /var/lib/apt/lists/*
##FROM ros:kinetic-robot-xenial

# install ros packages
#RUN apt-get update && apt-get install -y \
#    ros-kinetic-desktop=1.3.1-0* \
#    && rm -rf /var/lib/apt/lists/*
##FROM osrf/ros:kinetic-desktop-xenial

# install ros packages
#RUN apt-get update && apt-get install -y \
#    ros-kinetic-desktop-full=1.3.1-0* \
#    && rm -rf /var/lib/apt/lists/*
#-------------------

# install vim
#RUN apt-get update && apt-get install -y \
#    vim \
#    wget \
#    x11-apps \
#    && rm -rf /var/lib/apt/lists/*

# generate /root/work directory
WORKDIR /root/work

# copy .bashrc from host to target /root directory
ADD .bashrc /root

