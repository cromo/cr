FROM cromo/lektor
MAINTAINER Cristian Romo "cristian.g.romo@gmail.com"

RUN apt-get update && \
  apt-get install \
    rsync \
    ssh \
    -y && \
  rm -rf /var/lib/apt/lists/*

ARG external_username
ARG external_uid
ARG external_gid
RUN mkdir /home/$external_username && \
  groupadd --gid 1000 $external_username && \
  useradd --uid $external_uid --gid $external_gid $external_username && \
  chown $external_username /home/$external_username /source && \
  chgrp $external_username /home/$external_username /source
USER $external_username