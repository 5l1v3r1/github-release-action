FROM ubuntu:latest

COPY ./contrib/semver ./contrib/semver
RUN install ./contrib/semver /usr/local/bin
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
