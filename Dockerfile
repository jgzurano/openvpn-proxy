FROM alpine:edge

RUN apk add --no-cache openvpn tinyproxy runit

RUN apk add --no-cache ca-certificates bash wget openresolv \
    && apk add --no-cache --virtual .build-deps gcc make musl-dev \
    && cd /tmp \
    && wget https://github.com/rofl0r/microsocks/archive/v1.0.1.tar.gz \
    && tar -xzvf v1.0.1.tar.gz \
    && cd microsocks-1.0.1 \
    && make \
    && make install \
    # always add the docker DNS server
    && grep -qxF 'nameserver 127.0.0.11' /etc/resolv.conf || echo 'nameserver 127.0.0.11' >> /etc/resolv.conf \
    && apk del .build-deps wget

COPY update-resolv-conf.sh /etc/openvpn/update-resolv-conf.sh
RUN chmod +x /etc/openvpn/update-resolv-conf.sh
COPY entrypoint.sh /entrypoint.sh
COPY tinyproxy.conf /etc/tinyproxy/tinyproxy.conf
RUN chmod +x /entrypoint.sh

EXPOSE 8888
EXPOSE 8889

CMD ["/entrypoint.sh"]
