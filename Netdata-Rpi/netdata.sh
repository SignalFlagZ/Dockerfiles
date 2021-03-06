#!/bin/bash
# Netdata for RPi build script
# Signal Flag Z

CMD=`basename $0`
dname=rpinetdata

while getopts :p OPT
do
  case $OPT in
      p ) FLG_PULL="TRUE";;
      * ) echo "Usage: $CMD [-p] [-h]"
          echo "-h : help"
          echo "-p : Pull latest image"
          exit 1 ;;
  esac
done

if [ "$(docker ps -q -f name=${dname})" ]; then
echo Stop container ${dname}.
  docker stop ${dname}
fi
if [ "$(docker ps -aq -f status=exited -f name=$dname)" ]; then
echo Remove container ${dname}.
  docker rm ${dname}
fi

if [ "$FLG_PULL" = "TRUE" ]; then
  if [ "$(docker images -q -f before=rpinetdata)" ]; then
    echo Delete image ${dname}.
    docker rmi ${dname}
  fi
  docker build --pull --tag ${dname} .
else
  docker build --tag ${dname} .
fi

docker run -d --restart=unless-stopped --name=${dname} -p 19999:19999 \
  -v /proc:/host/proc:ro \
  -v /sys:/host/sys:ro \
  -v /var/run/docker.sock:/var/run/docker.sock:ro \
  --cap-add SYS_PTRACE \
  --security-opt apparmor=unconfined \
  ${dname}
  
  echo 'Open URL http://your-Pi-IP:19999/rpi.html'
  echo Docker image and container name is ${dname}.
