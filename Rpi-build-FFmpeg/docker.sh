#!/bin/bash
# Build image and run buildFF script.
# Signal Flag Z

docker build --rm=true -t buildffbase .
docker run -it --name buildff buildffbase
# To change ALSA version.
# docker run -it --env V_ALSA=1.1.9 --name buildff buildffbase
docker cp buildff:/root/bin/ffmpeg ./
docker cp buildff:/root/bin/ffplay ./
docker cp buildff:/root/bin/ffprobe ./
