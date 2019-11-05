FROM debian:latest

# System Dependencies
RUN apt-get update && apt-get install -y \
		siproxd \
    dumb-init \
	--no-install-recommends && rm -r /var/lib/apt/lists/*

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/usr/bin/siproxd"]
