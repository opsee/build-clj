FROM frolvlad/alpine-oraclejdk8
MAINTAINER Cliff Moon <cliff@opsee.co>

ENV LEIN_ROOT true

RUN apk add --update openssl bash git build-base m4 autoconf automake libtool && \
	wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein -O /usr/local/bin/lein &&\
	chmod a+x /usr/local/bin/lein && \
	lein && \
	wget https://github.com/google/protobuf/archive/v3.0.0-alpha-3.tar.gz && \
    tar -xzf v3.0.0-alpha-3.tar.gz && \
    cd protobuf-3.0.0-alpha-3 && \
    ./autogen.sh && \
    ./configure --disable-debug --disable-dependency-tracking && \
    make && \
    make install && \
    cd .. && \
	git clone https://github.com/grpc/grpc-java.git && \
	cd grpc-java/compiler && \
	ln -s /usr/local/include/google /usr/include/google && \
	../gradlew java_pluginExecutable

VOLUME /build

COPY build.sh /build.sh

CMD ["/build.sh"]