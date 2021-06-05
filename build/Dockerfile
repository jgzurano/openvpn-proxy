FROM alpine:edge
LABEL maintainer "Juan Zurano jgzurano@gmail.com"

RUN apk add --no-cache openvpn tinyproxy runit \
    bash ca-certificates wget curl \
    bind-tools openssh-client openresolv openssl \
    nmap nmap-scripts

RUN apk add --no-cache --virtual .build-deps gcc make musl-dev \
    && cd /tmp && wget -O microsocks.tar.gz -q https://github.com/rofl0r/microsocks/archive/v1.0.1.tar.gz \
    && tar -xzvf microsocks.tar.gz \
    && cd microsocks-* \
    && make \
    && make install \
    # always add the docker DNS server
    && grep -qxF 'nameserver 127.0.0.11' /etc/resolv.conf || echo 'nameserver 127.0.0.11' >> /etc/resolv.conf \
    && apk del .build-deps

COPY update-resolv-conf.sh /etc/openvpn/update-resolv-conf.sh
RUN chmod +x /etc/openvpn/update-resolv-conf.sh
COPY entrypoint.sh /entrypoint.sh
COPY tinyproxy.conf /etc/tinyproxy/tinyproxy.conf
RUN chmod +x /entrypoint.sh

EXPOSE 8888
EXPOSE 8889

CMD ["/entrypoint.sh"]
