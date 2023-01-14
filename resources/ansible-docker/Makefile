CURRENT_TIME = $(shell date +'%y.%m.%d %H:%M:%S')
CURRENT_TAG = "dev"

build: 
	docker build -t emhavis/pkc_agent:${CURRENT_TAG} .

buildAndPush:
	docker build -t emhavis/pkc_agent:${CURRENT_TAG} .
	docker push emhavis/pkc_agent:${CURRENT_TAG}

push:
	docker push emhavis/pkc_agent:${CURRENT_TAG}

buildMulti:
#	docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 -t emhavis/pkc_agent:${CURRENT_TAG} --push .
	docker buildx build --platform linux/amd64,linux/arm64 -t emhavis/pkc_agent:${CURRENT_TAG} --push .

