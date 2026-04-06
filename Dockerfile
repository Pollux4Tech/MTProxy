dev zlib1g-dev
RUN git clone https://github.com/TelegramMessenger/MTProxy /mtproxy
WORKDIR /mtproxy
RUN make
EXPOSE 443
CMD ./objs/bin/mtproto-proxy -u nobody -p 8888 -H 443 -S ${SECRET} --aes-pwd proxy-secret proxy-multi.conf -M 1
