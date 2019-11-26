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
ONBUILD RUN /usr/bin/freshclam --datadir="/clamavdb"
ENV PATH="/scanner:${PATH}"
COPY scan.sh ./
