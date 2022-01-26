FROM pihole/pihole:latest
	
COPY ./install.sh /
COPY ./config.yml /tmp

RUN /bin/bash /install.sh \
    && rm -f /install.sh
