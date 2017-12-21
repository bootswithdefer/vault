FROM vault:latest
MAINTAINER Jesse DeFer <docker-vault@dotd.com>

RUN addgroup -g 513 docker && adduser -D -u 1000 -G docker jenkins
