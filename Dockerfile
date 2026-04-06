FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y git build-essential libssl-dev zlib1g-dev curl
RUN git clone https://github.com/TelegramMessenger/MTProxy.git /app
WORKDIR /app
RUN make
EXPOSE 443
CMD curl -s https://core.telegram.org/getProxySecret -o proxy-secret && \
    curl -s https://core.telegram.org/getProxyConfig -o proxy-multi.conf && \
    ./objs/bin/mtproto-proxy -u nobody -p 8888 -H 443 \
    -S dd000102030405060708090a0b0c0d0e0f \
    --aes-pwd proxy-secret proxy-multi.conf -M 1
