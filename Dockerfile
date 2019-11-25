FROM alpine:latest
WORKDIR /scanner
RUN apk add --no-cache \
    bash \
    clamav \
    rsyslog \
    wget \
    clamav-libunrar
RUN mkdir "/clamavdb"
RUN chown 100:101 "/clamavdb"
RUN /usr/bin/freshclam --datadir="/clamavdb"
COPY scan.sh ./
