FROM pihole/pihole:master-buster
	
COPY ./install.sh /
COPY ./config.yaml /tmp

RUN /bin/bash /install.sh \
    && rm -f /install.sh