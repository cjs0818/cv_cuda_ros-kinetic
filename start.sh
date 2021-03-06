# If OS is OSX then,
# you should do the following first in the other terminal
# socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\"

OS=OSX
#OS=Linux


EN0=en0
#EN0=enp0s5
#EN0=enp0s31f6


#-------------
DISPLAY_IP=$(ifconfig $EN0 | grep inet | awk '$1=="inet" {print $2}')
XSOCK=/tmp/.X11-unix
#XAUTH=/tmp/.docker.xauth
#xauth nlist :0 | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -
#-------------

# Acquire parent directory as WORKDIR
WORKDIR=$(dirname $(pwd))
#WORKDIR="$(dirname "$(pwd)")"

IMAGE_ID=jschoi/cv_cuda_ros-kinetic
NAME_ID=jschoi_cv_cuda_ros_kinetic


#--------------------------------
if [ $OS = "OSX" ]; then
  DOCKER=docker
  XDISP=DISPLAY=$DISPLAY_IP:0  # for OSX
  #WORKDIR=/Users/jschoi/work/Yolo
else
  DOCKER=nvidia-docker  
  XDISP="DISPLAY"             # for Linux
  #WORKDIR=/home/jschoi/work/Yolo
fi


#    --env "DISPLAY" \
#    --env DISPLAY=$DISPLAY_IP:0 \
#--------------------------------

xhost + $DISPLAY_IP

$DOCKER run -it --rm \
    --env $XDISP \
    --env="QT_X11_NO_MITSHM=1" \
    --env LIBGL_ALWAYS_INDIRECT=1 \
    --volume $XSOCK:$XSOCK:ro \
    --volume $WORKDIR:/root/work:rw \
    --name $NAME_ID \
    -p 22345:11345 \
    $IMAGE_ID \
    /bin/bash
#export containerId=$(docker ps -l -q)

#xhost +local:`docker inspect --format='{{ .Config.Hostname }}' $containerId`
#docker start $containerId
#docker attach $containerId
