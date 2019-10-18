FROM woahbase/alpine-github

COPY ./contrib/semver ./contrib/semver
RUN install ./contrib/semver /usr/local/bin
COPY entrypoint.sh /entrypoint.sh

RUN apk update && apk add curl jq hub

ENTRYPOINT ["/entrypoint.sh"]
