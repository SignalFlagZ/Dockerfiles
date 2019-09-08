# Rpi-build-FFmpeg
Building the FFmpeg on Raspberry Pi with Docker.  
Run `Docker.sh`. It will build Docker image for building FFmpeg and run`buildFF.sh` in its container.  
To change ALSA version, Edit `Docker.sh` and set environment variable `V_ALSA`.  
  
The files `ffmpeg`, `ffplay` and `ffprobe` will be in current directory when the script finishes running. It includes non-free Libs.
