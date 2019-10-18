FROM debian:10.1

COPY ./contrib/semver ./contrib/semver
RUN install ./contrib/semver /usr/local/bin
RUN apt update && apt install -y curl jq hub
ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
