FROM netdata/netdata
LABEL maintainer "Signal Flag Z"

RUN sed -i -e 's/^# sensors=force/sensors=force/' /usr/lib/netdata/conf.d/charts.d.conf
COPY --chown=netdata:netdata rpi.html /usr/share/netdata/web
