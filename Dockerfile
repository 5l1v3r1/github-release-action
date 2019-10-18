FROM debian

COPY ./contrib/semver ./contrib/semver
RUN install ./contrib/semver /usr/local/bin
COPY entrypoint.sh /entrypoint.sh

RUN apt update && apt install jq hub

ENTRYPOINT ["/entrypoint.sh"]
