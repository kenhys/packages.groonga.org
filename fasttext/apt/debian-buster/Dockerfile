FROM debian:buster

ENV DEBIAN_FRONTEND noninteractive

ARG DEBUG

RUN \
  quiet=$([ "${DEBUG}" = "yes" ] || echo "-qq") && \
  apt update ${quiet} && \
  apt install -y -V ${quiet} \
    build-essential \
    cmake \
    debhelper \
    devscripts \
    lsb-release && \
  apt clean && \
  rm -rf /var/lib/apt/lists/*
