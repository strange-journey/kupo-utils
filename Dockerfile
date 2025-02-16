FROM python:3.13.2-alpine

ARG S6_OVERLAY_VERSION=3.2.0.2
ARG S6_ARCH=x86_64
ARG PYROCORE_REVISION=e8ededb
ARG UID=1000
ARG GID=1000

WORKDIR /app
COPY scripts .
COPY services.d /etc/services.d

RUN apk add --no-cache --update git bash
RUN adduser -D -u ${UID} -g ${GID} kupo && \
    mkdir -p /config && \
    chown -R kupo:kupo /config

RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir --upgrade pyrosimple

RUN apk add --no-cache --update supercronic
COPY crontab .

ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-${S6_ARCH}.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-${S6_ARCH}.tar.xz

ENTRYPOINT [ "/init" ]
