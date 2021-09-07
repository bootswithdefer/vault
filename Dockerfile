FROM vault:latest
MAINTAINER Jesse DeFer <docker-vault@dotd.com>

RUN addgroup -g 513 docker && adduser -D -u 1000 -G docker jenkins

ENV UNSEALER_VER=0.3.1

RUN apk add --no-cache ca-certificates gnupg && \
    wget https://github.com/jetstack/vault-unsealer/releases/download/${UNSEALER_VER}/vault-unsealer_${UNSEALER_VER}_checksums.txt && \
    wget https://github.com/jetstack/vault-unsealer/releases/download/${UNSEALER_VER}/vault-unsealer_${UNSEALER_VER}_linux_amd64 && \
    grep linux_amd64 vault-unsealer_${UNSEALER_VER}_checksums.txt | sha256sum -c && \
    mv vault-unsealer_${UNSEALER_VER}_linux_amd64 /bin/vault-unsealer && \
    chmod a+x /bin/vault-unsealer && \
    apk del gnupg && \
    rm -rf /root/.gnupg && \
    rm vault-unsealer_${UNSEALER_VER}_checksums.txt
