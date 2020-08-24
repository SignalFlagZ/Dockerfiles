FROM netdata/netdata
LABEL maintainer "Signal Flag Z"

ENV DO_NOT_TRACK=1
RUN sed -i -e '$a sensors=force' /usr/lib/netdata/conf.d/charts.d.conf
COPY rpi.html /usr/share/netdata/web
