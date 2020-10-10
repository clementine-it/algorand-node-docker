FROM debian:latest

# ----------------------------------------------------
LABEL author="Giuseppe Zileni <giuseppe.zileni@gmail.com>" maintainer="Giuseppe Zileni <giuseppe.zileni@gmail.com>" version="1.0.0" \
  description="This is a base image for building clementine/algorand-node"

WORKDIR ~/node/data 
WORKDIR /var/lib/algorand

# ----------------------------------------------------
RUN echo 'APT::Install-Recommends 0;' >> /etc/apt/apt.conf.d/01norecommends \
    && echo 'APT::Install-Suggests 0;' >> /etc/apt/apt.conf.d/01norecommends \
    && apt-get -y update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y sudo apt-utils wget curl ca-certificates unzip cmake git openssl gnupg2 curl software-properties-common unattended-upgrades \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/man/?? /usr/share/man/??_*

ENV ALGORAND_DATA=~/node/data 
ENV ALGORAND_DATA=/var/lib/algorand

RUN curl -O https://releases.algorand.com/key.pub
RUN apt-key add key.pub
RUN add-apt-repository "deb https://releases.algorand.com/deb/ stable main"
RUN DEBIAN_FRONTEND=noninteractive apt-get -y update

# To get both algorand and the devtools:
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y algorand-devtools

# Or, to only install algorand:
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y algorand