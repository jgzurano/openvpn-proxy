IMAGE = quay.io/jgzurano/openvpn-proxy
TAG = latest

info:
	@echo $(TAG)
	@echo $(IMAGE)

build:
	docker build -t $(IMAGE):$(TAG) .
