#!/bin/bash
# Netdata for RPi build script
# Signal Flag Z

dname=rpinetdata
docker build -t ${dname} .

if [ "$(docker ps -q -f name=${dname})" ]; then
echo Container ${dname} is running. Stops it.
  docker stop ${dname}
fi
if [ "$(docker ps -aq -f status=exited -f name=$dname)" ]; then
echo Container ${dname} exist. Remove it.
  docker rm ${dname}
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
