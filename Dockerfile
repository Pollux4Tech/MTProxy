FROM alpine:3.18

RUN apk add --no-cache curl

RUN curl -L https://github.com/TelegramMessenger/MTProxy/releases/download/v0.0.1/mtproto-proxy-linux-amd64 -o /usr/local/bin/mtproto-proxy 2>/dev/null || true

FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y wget curl openssl && rm -rf /var/lib/apt/lists/*
RUN curl https://core.telegram.org/getProxySecret -o proxy-secret
RUN curl https://core.telegram.org/getProxyConfig -o proxy-multi.conf
WORKDIR /app
COPY --from=0 /usr/local/bin/mtproto-proxy /app/mtproto-proxy 2>/dev/null || true
RUN wget -q https://github.com/TelegramMessenger/MTProxy/releases/latest/download/mtproto-proxy -O /app/mtproto-proxy || true
RUN chmod +x /app/mtproto-proxy
EXPOSE 443
CMD ["/bin/sh", "-c", "curl -s https://core.telegram.org/getProxySecret -o proxy-secret && curl -s https://core.telegram.org/getProxyConfig -o proxy-multi.conf && /app/mtproto-proxy -u nobody -p 8888 -H 443 -S ${SECRET} --aes-pwd proxy-secret proxy-multi.conf -M 1"]
