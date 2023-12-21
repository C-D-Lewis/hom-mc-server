FROM ubuntu:jammy as base

RUN apt update && apt upgrade -y
RUN apt install openjdk-17-jre -y 

from base

EXPOSE 25565/tcp
EXPOSE 19132/udp

WORKDIR /server

ADD . /server/

CMD /server/scripts/start.sh
