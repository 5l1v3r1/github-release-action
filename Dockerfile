FROM node:10-alpine

COPY ./contrib/semver ./contrib/semver
COPY ./release-uploader ./release-uploader
RUN install ./contrib/semver /usr/local/bin
RUN install ./release-uploader /usr/local/bin

COPY entrypoint.sh /entrypoint.sh


RUN apk add --no-cache python python-dev python3 python3-dev \
    linux-headers build-base bash git ca-certificates && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    rm -r /root/.cache

RUN apk add --no-cache tzdata && \
    cp /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime && \
    echo "America/Sao_Paulo" > /etc/timezone

ENTRYPOINT ["/entrypoint.sh"]
