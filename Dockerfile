#--------------------
# For CUDA
#FROM jschoi/yolo
#FROM nvidia/cuda
FROM jschoi/cv_cuda
#RUN ls -al
#--------------------

#-------------------
#  RoS

# install packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    dirmngr \
    gnupg2 \
    && rm -rf /var/lib/apt/lists/*

# setup keys
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 421C365BD9FF1F717815A3895523BAEEB01FA116

# setup sources.list
RUN echo "deb http://packages.ros.org/ros/ubuntu xenial main" > /etc/apt/sources.list.d/ros-latest.list

# install bootstrap tools
RUN apt-get update && apt-get install --no-install-recommends -y \
    python-rosdep \
    python-rosinstall \
    python-vcstools \
    && rm -rf /var/lib/apt/lists/*

# setup environment
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# bootstrap rosdep
RUN rosdep init \
    && rosdep update

# install ros packages
ENV ROS_DISTRO kinetic
RUN apt-get update && apt-get install -y \
    ros-kinetic-ros-core=1.3.1-0* \
    && rm -rf /var/lib/apt/lists/*

# setup entrypoint
COPY ./ros_entrypoint.sh /

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]

#FROM ros:kinetic-ros-core-xenial

RUN apt-get update && apt-get install -y \
    ros-kinetic-ros-base=1.3.1-0* \
    ros-kinetic-robot=1.3.1-0* \
    ros-kinetic-desktop=1.3.1-0* \
    ros-kinetic-desktop-full=1.3.1-0* \
    && rm -rf /var/lib/apt/lists/*

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

