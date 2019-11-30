#!/bin/bash
# FFmpeg build script
# Signal Flag Z

# V_ALSA="1.1.9" # ALSA Version

apt update
apt -y upgrade

mkdir -p ~/ffmpeg_sources ~/bin

echo "building x264."
cd ~/ffmpeg_sources && \
git -C x264 pull 2> /dev/null || git clone --depth 1 https://code.videolan.org/videolan/x264.git && \
cd x264 && \
PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" \
  ./configure \
    --prefix="$HOME/ffmpeg_build" \
    --bindir="$HOME/bin" \
    --enable-static \
    --enable-pic && \
PATH="$HOME/bin:$PATH" make -j4 && \
make install



cd ~/ffmpeg_sources
echo "building mmal."
git clone https://github.com/raspberrypi/userland.git
cd userland
./buildme

cd ~/ffmpeg_sources
echo "building alsa."
git clone git://source.ffmpeg.org/ffmpeg.git ffmpeg --depth 1
wget ftp://ftp.alsa-project.org/pub/lib/alsa-lib-$V_ALSA.tar.bz2
tar xjvf alsa-lib-$V_ALSA.tar.bz2
cd /home/alsa-lib-$V_ALSA
PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" \
  ./configure --prefix="$HOME/ffmpeg_build" \
&& PATH="$HOME/bin:$PATH" make -j4 \
&& make install

export LD_LIBRARY_PATH="/opt/vc/lib"
cd ~/ffmpeg_sources \
&& wget -O ffmpeg-snapshot.tar.bz2 https://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2 \
&& tar xjvf ffmpeg-snapshot.tar.bz2 \
&& cd ffmpeg \
&& PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" LD_LIBRARY_PATH="/opt/vc/lib" \
 ./configure \
  --prefix="$HOME/ffmpeg_build" \
  --pkg-config-flags="--static" \
  --extra-cflags="-I$HOME/ffmpeg_build/include" \
  --extra-ldflags="-L$HOME/ffmpeg_build/lib" \
  --extra-libs="-ldl" \
  --bindir="$HOME/bin" \
  --enable-gpl \
  --enable-mmal \
  --enable-omx-rpi \
  --enable-omx \
  --enable-libfreetype \
  --enable-libx264 \
  --enable-nonfree \
  --disable-doc \
  --disable-debug \
&& PATH="$HOME/bin:$PATH" make -j4 \
&& make install \
&& hash -r

echo "done."
