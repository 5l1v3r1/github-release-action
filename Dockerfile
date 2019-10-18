FROM woahbase/alpine-github

COPY ./contrib/semver ./contrib/semver

COPY entrypoint.sh /entrypoint.sh

RUN apk update && apk add curl jq

ENTRYPOINT ["/entrypoint.sh"]
