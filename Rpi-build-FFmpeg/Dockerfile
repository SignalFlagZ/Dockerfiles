FROM debian
LABEL maintainer "Signal Flag Z"

RUN echo "now building..." \
  && echo "updating..." \
  && apt update \
  && apt upgrade -y \
  &&  echo "install libs..." \
  && apt -y install sudo autoconf automake build-essential cmake git-core libass-dev libfreetype6-dev libsdl2-dev libtool libva-dev libvdpau-dev libvorbis-dev libxcb1-dev libxcb-shm0-dev libxcb-xfixes0-dev pkg-config texinfo wget zlib1g-dev \
  && apt -y install nasm yasm sudo\
  && apt -y install libx264-dev libvpx-dev \
  && apt -y autoremove \
  && echo "Done." \
  && apt clean
COPY ./buildFF.sh  /home

# ALSA Version
ENV V_ALSA="1.2.1.1"

CMD ["/bin/bash", "-c",  "/home/buildFF.sh"]
