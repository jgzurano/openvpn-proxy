IMAGE = quay.io/jgzurano/openvpn-proxy
TAG = latest

.PHONY: build

info:
	@echo "image: $(IMAGE):$(TAG)"

build:
	cd ./build && docker build -t $(IMAGE):$(TAG) . && cd
