FROM alpine:3 AS builder

ENV SOFTETHER_VPN_VERSION master

WORKDIR /tmp
RUN apk add --no-cache \
    binutils \
    build-base \
    zlib-dev \
    openssl-dev \
    readline-dev \
    ncurses-dev \
    musl-dev \
    gnu-libiconv \
    libpthread-stubs \
    tar \
    gzip \
    make \
    git \
    && git clone https://github.com/SoftEtherVPN/SoftEtherVPN_Stable.git -b ${SOFTETHER_VPN_VERSION} \
    && cd SoftEtherVPN_Stable \
    && ./configure \
    && make install

FROM alpine:3
COPY --from=builder /usr/bin/vpn* /usr/bin/
COPY --from=builder /usr/vpnserver/ /usr/vpnserver/
COPY --from=builder /usr/vpncmd/ /usr/vpncmd/
COPY --from=builder /usr/vpnclient/ /usr/vpnclient/
COPY --from=builder /usr/vpnbridge/ /usr/vpnbridge/

RUN apk add --no-cache \
    openssl \
    readline

EXPOSE 443/tcp 992/tcp 1194/tcp 1194/udp 5555/tcp 500/udp 4500/udp
CMD ["/usr/bin/vpnserver", "execsvc"]

