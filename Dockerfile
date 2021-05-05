FROM ubuntu:20.04

## Actualización del sistema
RUN apt-get update && apt-get -y upgrade

## Update system
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

## Preesed TZData
RUN echo "tzdata tzdata/Areas select America" > /tmp/preseed.txt; \
    echo "tzdata tzdata/Zones/America select Mexico_City" >> /tmp/preseed.txt; \
    debconf-set-selections /tmp/preseed.txt && \
    apt-get install -y tzdata

## Install utilities
RUN apt-get install -y git iputils-ping wget unzip curl nano build-essential

## Install NodeJS
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - \
    && apt-get install -y nodejs

## Install Yarn
RUN npm install --global yarn

## Ports
EXPOSE 3000
EXPOSE 3030

# Workdir
WORKDIR /home/

# Entrypoint
ENTRYPOINT /bin/bash