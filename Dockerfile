# Use Debian, because TS doesn't seem to work very will with Alpine.
FROM debian:jessie

ARG ts_version
ENV LANG C.UTF-8

COPY config.layout /usr/src
RUN	set -ex									\
	&& apt-get update							\
	&& apt-get -y install tar gcc bzip2 libc6-dev linux-libc-dev make curl	\
		libncursesw5-dev openssl libssl-dev zlib1g-dev libpcre3-dev	\
		perl libxml2-dev libcap-dev tcl8.6-dev libhwloc-dev		\
		libgeoip-dev libmysqlclient-dev libkyotocabinet-dev		\
		libreadline-dev ca-certificates libtcl8.6 libgeoip1		\
		libkyotocabinet16 libmysqlclient18 				\
	&& mkdir -p /usr/src							\
	&& cd /usr/src								\
	&& curl -L http://www-eu.apache.org/dist/trafficserver/trafficserver-${ts_version}.tar.bz2 | bzip2 -dc | tar xf - \
	&& cd trafficserver-${ts_version}					\
	&& cp /usr/src/config.layout .						\
	&& env LDFLAGS='-Wl,-rpath,/usr/local/lib'				\
		./configure							\
		--with-user=nobody --with-group=nogroup				\
		--enable-wccp --enable-hardening --enable-luajit		\
		--enable-tproxy --enable-experimental-plugins			\
		--enable-layout=Torchbox					\
	&& make -j$(getconf _NPROCESSORS_ONLN)					\
	&& make install								\
	&& apt-get -y purge gcc libc6-dev linux-libc-dev make curl		\
		libncursesw5-dev libssl-dev zlib1g-dev libpcre3-dev libxml2-dev	\
		libcap-dev tcl8.6-dev libhwloc-dev libgeoip-dev			\
		libmysqlclient-dev libkyotocabinet-dev libreadline-dev		\
	&& apt-get -y autoremove						\
	&& rm -rf /usr/src /var/cache/apt /var/lib/apt/lists/*

CMD ["/usr/local/bin/traffic_cop", "-o"]
