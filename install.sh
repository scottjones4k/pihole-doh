#!/bin/bash

# install basic packages
apt-get -y update \
    && apt-get -y dist-upgrade \
    && apt-get -y install bash wget

# install cloudflared
cd /tmp \
    && wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb \
    && apt-get install ./cloudflared-linux-amd64.deb \
    && rm -f .//cloudflared-linux-amd64.deb
    
# clean cloudflared config
mkdir -p /etc/cloudflared \
    && rm -f /etc/cloudflared/config.yml

# add cloudflared config
cd /tmp \
    && mkdir -p /etc/cloudflared \
    && cp -n ./config.yml /etc/cloudflared/ \
    && rm -f ./config.yml

# run cloudflared as service
cloudflared service install --legacy
/etc/init.d/cloudflared start
	
# clean up
apt-get -y autoremove \
    && apt-get -y autoclean \
    && apt-get -y clean \
    && rm -fr /tmp/* /var/tmp/* /var/lib/apt/lists/*
