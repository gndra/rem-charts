all: build_n_push

build_n_push:
	docker build . -t us.gcr.io/$(project)/rest-service
	docker push us.gcr.io/$(project)/rest-service
