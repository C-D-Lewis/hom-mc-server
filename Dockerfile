FROM ubuntu:jammy as base

# Update base image
RUN apt update && apt upgrade -y

# Install dependencies
RUN apt install openjdk-17-jre -y 

FROM base

# Expose ports
EXPOSE 25565/tcp
# EXPOSE 19132/udp

WORKDIR /server

ADD . /server/

CMD /server/scripts/start.sh
