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

# Download latest virus database
RUN /usr/bin/freshclam --datadir="/clamavdb"

# Refresh the DB when this image is used as the base for another build.
# https://docs.docker.com/engine/reference/builder/#onbuild
ONBUILD RUN /usr/bin/freshclam --datadir="/clamavdb"

ENV PATH="/scanner:${PATH}"
COPY scan.sh ./
