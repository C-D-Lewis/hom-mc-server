FROM ubuntu:jammy as base

RUN apt update && apt upgrade -y

RUN apt install openjdk-17-jre -y 

FROM base

EXPOSE 25565/tcp

WORKDIR /server

ADD . /server/

CMD /server/scripts/start.sh
