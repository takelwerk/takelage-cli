FROM alpine:latest

ARG version

COPY entrypoint.sh /entrypoint

COPY takelship.yml /takelship.yml

RUN chmod 755 /entrypoint

RUN echo "$version" > /version

ENTRYPOINT ["/entrypoint"]
