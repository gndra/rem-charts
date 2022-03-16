all: build_n_push

VERSION=1.0.0

build_n_push:
	docker build . -t us.gcr.io/$(project)/rest-service:$(VERSION)
	docker push us.gcr.io/$(project)/rest-service:$(VERSION)
