FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y git build-essential libssl-dev zlib1g-dev curl
RUN git clone https://github.com/TelegramMessenger/MTProxy.git /app
WORKDIR /app
RUN make
RUN curl -s https://core.telegram.org/getProxySecret -o proxy-secret
RUN curl -s https://core.telegram.org/getProxyConfig -o proxy-multi.conf
EXPOSE 443
CMD ./objs/bin/mtproto-proxy -u nobody -p 8888 -H 443 -S ee00112233445566778899aabbccddeeff --aes-pwd proxy-secret proxy-multi.conf -M 1
