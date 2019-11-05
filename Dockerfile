FROM debian:latest

# System Dependencies
RUN apt-get update && apt-get install -y \
	siproxd \
	dumb-init \
	--no-install-recommends && rm -r /var/lib/apt/lists/*

RUN sed -i "s/daemonize = 1/daemonize = 0/" /etc/siproxd.conf

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/usr/sbin/siproxd"]
