#!/bin/bash
# FFmpeg build script
# Signal Flag Z

docker build -t rpinetdata .
docker run -d --name=rpinetdata   -p 19999:19999 \
  -v /proc:/host/proc:ro \
  -v /sys:/host/sys:ro \
  -v /var/run/docker.sock:/var/run/docker.sock:ro \
  --cap-add SYS_PTRACE \
  --security-opt apparmor=unconfined \
  rpinetdata
  