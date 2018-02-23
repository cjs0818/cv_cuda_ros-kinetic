# Install Docker
At first, install Docker to your system

* Download Docker CE (Community Edition)

  * https://www.docker.com/community-edition


* WORKDIR is assummed to be your working directory

  ```
  $ cd WORKDIR
  ```


# Install darknet

  ```
  WORKDIR$ git clone https://github.com/AlexeyAB/darknet
  ```


 * Download yolo weights

  ```
  WORKDIR$ cd darknet
  WORKDIR/darknet$ wget https://pjreddie.com/media/files/yolo.weights
  WORKDIR/darknet$ wget https://pjreddie.com/media/files/yolo-voc.weights
  WORKDIR/darknet$ wget https://pjreddie.com/media/files/tiny-yolo.weights
  WORKDIR/darknet$ wget https://pjreddie.com/media/files/yolo9000.weights
  ```


# Build Docker

  ```
  WORKDIR/darknet$ cd ..
  WORKDIR$ git clone git@github.com:cjs0818/cv_cuda_ros-kinetc.git
  cd cv_cuda_ros-kinetic
  WORKDIR/yolo$ ./docker_build.sh
  ```
  
* Change DISPLAY_IP in start.sh according to your system (using ifconfig)

* Change WORKDIR in start.sh according to your system


# Start Docker

* Set up parameters such as DOCKER (nvidia-docker or docker), EN0 (ifconfig ...), WORKDIR in the 'start.sh' file

  ```
  DOCKER=nvidia-docker
  #DOCKER=docker

  #EN0=en0
  #EN0=enp0s5
  EN0=enp0s31f6
  
  #WORKDIR=/Users/jschoi/work/Yolo
  WORKDIR=/home/jschoi/work/Yolo
  ```

* Execute 'start.sh' file

  ```
  WORKDIR/cv_cuda_ros-kinetic$ ./start.sh

  # Compile darknet inside Docker
  /root/work$ cd /root/work/darknet
  
  # Modify paramaters in Makefile according to your system
  OPENCV=0 into OPENCV=1
  Set or unset GPU, CUDNN, ...

  /root/work/darknet$ make clean
  /root/work/darknet$ make

  # Test darknet
  /root/work/darknet$ chmod 755 image_voc.sh
  /root/work/darknet$ ./image_voc.sh
  ```
  

# Start RoS

  ```
  /root/work$ roscore
  ```

