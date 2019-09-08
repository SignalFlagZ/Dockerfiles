#!/bin/bash
# FFmpeg build script
# Signal Flag Z

# V_ALSA="1.1.9" # ALSA Version

apt update
apt -y upgrade

echo "building x264."
cd /home
git clone git://git.videolan.org/x264.git
cd /home/x264
./configure --enable-static --enable-shared
make -j4
make install
ldconfig

cd /home
echo "building mmal."
git clone https://github.com/raspberrypi/userland.git
cd /home/userland
./buildme

cd /home
echo "building alsa."
git clone git://source.ffmpeg.org/ffmpeg.git ffmpeg --depth 1
wget ftp://ftp.alsa-project.org/pub/lib/alsa-lib-$V_ALSA.tar.bz2
tar xjvf alsa-lib-$V_ALSA.tar.bz2
cd /home/alsa-lib-$V_ALSA
./configure --prefix=/home/ffmpeg
make -j4
make install

export LD_LIBRARY_PATH="/opt/vc/lib"
cd /home/ffmpeg
echo "building FFmpeg."
./configure --enable-gpl --enable-nonfree --enable-libx264 --enable-mmal --enable-omx-rpi --enable-omx --enable-libfreetype --enable-libfontconfig --enable-libfribidi --extra-cflags="-I/home/ffmpeg/include" --extra-ldflags="-L/home/ffmpeg/lib" --extra-libs="-ldl"
make -j4

echo "done."
