FROM ubuntu:latest

COPY ./contrib/semver ./contrib/semver
RUN install ./contrib/semver /usr/local/bin
COPY entrypoint.sh /entrypoint.sh
COPY release.py /release.py

RUN apt update && apt install -y git

ENTRYPOINT ["/entrypoint.sh"]
