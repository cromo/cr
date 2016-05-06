FROM cromo/lektor
MAINTAINER Cristian Romo "cristian.g.romo@gmail.com"

RUN apt-get update && \
  apt-get install \
    rsync \
    ssh \
    -y && \
  rm -rf /var/lib/apt/lists/*
RUN mkdir /home/cristian && \
  groupadd --gid 1000 cristian && \
  useradd --uid 1000 --gid 1000 cristian && \
  chown cristian /home/cristian /source && \
  chgrp cristian /home/cristian /source
USER cristian