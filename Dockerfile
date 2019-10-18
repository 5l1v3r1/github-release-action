FROM node:10-alpine

COPY ./contrib/semver ./contrib/semver
COPY ./release-uploader ./release-uploader
RUN install ./contrib/semver /usr/local/bin
RUN install ./release-uploader /usr/local/bin

COPY entrypoint.sh /entrypoint.sh

RUN apk add --no-cache python python-dev python3 python3-dev \
    linux-headers build-base bash git ca-certificates && \
    rm -r /root/.cache

ENTRYPOINT ["/entrypoint.sh"]
