# alpine-certificates:
# - Alpine, with ca-certificates installed. We can't assume that we'll be able
#   operate as root, or access the internet to install the package.
# - This image is intended to be based on alpine:latest, which is currently 3.10.
#   We're doing this to ensure the latest ca-certificates package.
ARG FROM_IMAGE=alpine
ARG ALPINE_VERSION=3.15
FROM $FROM_IMAGE:$ALPINE_VERSION

RUN apk --update --no-cache add ca-certificates

RUN sed -i 's/mozilla\/DST_Root_CA_X3.crt/!mozilla\/DST_Root_CA_X3.crt/g' /etc/ca-certificates.conf
RUN update-ca-certificates

COPY scripts/bundle-certificates /scripts/

VOLUME /etc/ssl/certs /usr/local/share/ca-certificates

CMD ["/scripts/bundle-certificates"]
