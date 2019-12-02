#!/bin/bash
# Build image and run buildFF script.
# Signal Flag Z
dname=buildff
docker build --rm=true -t ${dname} .
if [ "$(docker ps -q -f name=${dname})" ]; then
echo Container ${dname} is running. Stops it.
  docker stop ${dname}
fi
if [ "$(docker ps -aq -f status=exited -f name=$dname)" ]; then
echo Container ${dname} exist. Remove it.
  docker rm ${dname}
fi
docker run -it --name ${dname} ${dname}
# To change ALSA version.
# docker run -it --env V_ALSA=1.1.9 --name ${dname} ${dname}
docker cp buildff:/root/bin/ffmpeg ./
docker cp buildff:/root/bin/ffplay ./
docker cp buildff:/root/bin/ffprobe ./
