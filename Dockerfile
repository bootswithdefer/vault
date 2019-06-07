FROM vault:latest
MAINTAINER Jesse DeFer <docker-vault@dotd.com>

RUN addgroup -g 513 docker && adduser -D -u 1000 -G docker jenkins

ENV UNSEALER_VER=0.2.1

RUN apk add --no-cache ca-certificates gnupg && \
    gpg --keyserver pool.sks-keyservers.net --recv-keys 9A1C42C8F5AA3CE6 && \
    wget https://github.com/jetstack/vault-unsealer/releases/download/${UNSEALER_VER}/vault-unsealer_${UNSEALER_VER}_checksums.txt && \
    wget https://github.com/jetstack/vault-unsealer/releases/download/${UNSEALER_VER}/vault-unsealer_${UNSEALER_VER}_checksums.txt.asc && \
    mkdir vault-unsealer_${UNSEALER_VER}_linux_amd64 && \
    wget -P vault-unsealer_${UNSEALER_VER}_linux_amd64 https://github.com/jetstack/vault-unsealer/releases/download/${UNSEALER_VER}/vault-unsealer_${UNSEALER_VER}_linux_amd64 && \
    gpg --batch --verify vault-unsealer_${UNSEALER_VER}_checksums.txt.asc vault-unsealer_${UNSEALER_VER}_checksums.txt && \
    grep linux_amd64 vault-unsealer_${UNSEALER_VER}_checksums.txt | sha256sum -c && \
    mv vault-unsealer_${UNSEALER_VER}_linux_amd64/vault-unsealer_${UNSEALER_VER}_linux_amd64 /bin/vault-unsealer && \
    chmod a+x /bin/vault-unsealer && \
    apk del gnupg && \
    rm -rf /root/.gnupg && \
    rm vault-unsealer_${UNSEALER_VER}_checksums.txt vault-unsealer_${UNSEALER_VER}_checksums.txt.asc && \
    rmdir vault-unsealer_${UNSEALER_VER}_linux_amd64
