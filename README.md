# OpenVPN Proxy

A Tinyproxy/Microsocks container with OpenVPN - Built upon Alpine Linux

[![Docker Repository on Quay](https://quay.io/repository/jgzurano/openvpn-proxy/status "Docker Repository on Quay")](https://quay.io/repository/jgzurano/openvpn-proxy)

## Usage

```shell
docker run \
  -it --rm \
  --name openvpn-proxy \
  --device=/dev/net/tun --cap-add=NET_ADMIN \
  -e "LOCAL_NETWORK=10.0.0.0/8" \
  -v /path/to/file.ovpn:/app/ovpn/config/vpn.ovpn:ro \
  -v /path/to/creds.txt:/app/ovpn/config/creds.txt:ro \
  -v /etc/localtime:/etc/caltime:ro \
  -p 8888:8888 8889:8889 \
  quay.io/jgzurano/openvpn-proxy:latest
```

## Environment Variables

### LOCAL_NETWORK

The CIDR mask of the local IP addresses which will be acessing the proxy. This is so the response to a request makes it back to the client.
