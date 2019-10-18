FROM ubuntu:latest

COPY ./contrib/semver ./contrib/semver
COPY ./release-uploader ./release-uploader
RUN install ./contrib/semver /usr/local/bin
RUN install ./release-uploader /usr/local/bin

COPY entrypoint.sh /entrypoint.sh

RUN apt update && apt install -y git

ENTRYPOINT ["/entrypoint.sh"]
