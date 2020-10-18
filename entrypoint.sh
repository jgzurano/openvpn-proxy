#!/bin/sh

OVPN_FILE=$(ls /app/ovpn/config/*.ovpn)
OVPN_CREDS=$(ls /app/ovpn/config/*.txt)

if [ ! -f "$OVPN_FILE" ] ; then
    echo 'No OpenVPN config set'
    exit 1
fi

if [ ! -f "$OVPN_CREDS" ] ; then
    echo 'No OpenVPN creds set'
    exit 1
fi

if [ -z "$OVPN_DOMAIN" ] ; then
    echo 'No OpenVPN domain set'
    exit 1
fi

/usr/bin/tinyproxy -c /etc/tinyproxy/tinyproxy.conf

/usr/local/bin/microsocks -i 0.0.0.0 -p 8889 &

openvpn \
  --config "$OVPN_FILE" \
  --auth-user-pass "$OVPN_CREDS" \
  --script-security 2 \
  --up /etc/openvpn/update-resolv-conf.sh --up-restart \
  --down /etc/openvpn/update-resolv-conf.sh --down-pre \
  --dhcp-option DOMAIN "$OVPN_DOMAIN" \
  --keepalive 10 60 \
  --auth-retry interact
