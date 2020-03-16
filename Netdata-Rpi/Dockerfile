FROM netdata/netdata
LABEL maintainer "Signal Flag Z"

RUN sed -i -e '$a sensors=force' /usr/lib/netdata/conf.d/charts.d.conf
COPY rpi.html /usr/share/netdata/web
