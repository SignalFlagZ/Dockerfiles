#!/bin/bash
# FFmpeg build script
# Signal Flag Z

# V_ALSA="1.1.9" # ALSA Version

apt update
apt -y upgrade

mkdir -p /home/ffmpeg_sources /home/bin

echo "building x264."
cd /home
git clone git://git.videolan.org/x264.git
cd /home/x264
PATH="/home/bin:$PATH" PKG_CONFIG_PATH="/home/ffmpeg_build/lib/pkgconfig" ./configure --prefix="/home/ffmpeg_build"  --enable-static 
PATH="/home/bin:$PATH" make -j4
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
PATH="/home/bin:$PATH" PKG_CONFIG_PATH="/home/ffmpeg_build/lib/pkgconfig" ./configure --prefix="/home/ffmpeg_build"
PATH="/home/bin:$PATH" make -j4
make install

export LD_LIBRARY_PATH="/opt/vc/lib"
cd /home/ffmpeg
echo "building FFmpeg."
PATH="/home/bin:$PATH" PKG_CONFIG_PATH="/home/ffmpeg_build/lib/pkgconfig" \
  ./configure \
    --prefix="/home/ffmpeg_build"
    --pkg-config-flags="--static" \
    --enable-static \
    --enable-gpl \
    --enable-nonfree \
    --enable-libx264 \
    --enable-mmal \
    --enable-omx-rpi \
    --enable-omx \
    --enable-libfreetype \
    --enable-libfontconfig \
    --enable-libfribidi \
    --extra-cflags="-I/home/ffmpeg_build/include" \
    --extra-ldflags="-L/home/ffmpeg_build/lib" \
    --extra-libs="-ldl" \
    --disable-doc \
    --disable-debug 
PATH="/home/bin:$PATH" make -j4

echo "done."
