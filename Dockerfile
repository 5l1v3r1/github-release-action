FROM lgohr/github-hub

COPY ./contrib/semver ./contrib/semver
RUN install ./contrib/semver /usr/local/bin
RUN apt update && apt install -y curl jq
ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
