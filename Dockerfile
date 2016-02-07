FROM cromo/lektor
MAINTAINER Cristian Romo "cristian.g.romo@gmail.com"

RUN mkdir /home/cromo && \
  groupadd --gid 1000 cromo && \
  useradd --uid 1000 --gid 1000 cromo && \
  chown cromo /home/cromo /source && \
  chgrp cromo /home/cromo /source
USER cromo