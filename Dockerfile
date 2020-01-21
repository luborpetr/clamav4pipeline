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

COPY db-update.sh ./

# Download latest virus database
RUN ./db-update.sh

# Refresh the DB when this image is used as the base for another build.
# https://docs.docker.com/engine/reference/builder/#onbuild
ONBUILD RUN ./db-update.sh

ENV PATH="/scanner:${PATH}"
COPY scan.sh ./
