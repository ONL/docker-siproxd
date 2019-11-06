FROM fedora:latest as builder

RUN dnf install -y \
	wget \
	libosip2-devel \
	&& dnf groupinstall -y "Development Tools"

RUN wget 'https://downloads.sourceforge.net/project/siproxd/siproxd/0.8.2/siproxd-0.8.2.tar.gz?r=&ts=1573055515' -O siproxd-0.8.2.tar.gz
RUN tar -xzf siproxd-0.8.2.tar.gz
RUN ./configure --enable-static
RUN make
RUN make install
RUN ls -l /usr/sbin | grep sip
	

FROM fedora:latest
# System Dependencies
RUN dnf install -y \
	dumb-init \
	 && dnf clean all
	 
COPY --from=builder /usr/sbin/siproxd /usr/sbin/siproxd

RUN echo "daemonize = 0" > /etc/siproxd.conf

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/usr/sbin/siproxd"]
