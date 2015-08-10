FROM quay.io/opsee/build-base
MAINTAINER Cliff Moon <cliff@opsee.co>

ENV LEIN_ROOT true

RUN wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein -O /usr/local/bin/lein &&\
	chmod a+x /usr/local/bin/lein && \
	lein && \
	git clone https://github.com/grpc/grpc-java.git && \
	cd grpc-java/compiler && \
	git checkout tags/v0.7.2 && \
	ln -s /usr/local/include/google /usr/include/google && \
	../gradlew java_pluginExecutable && \
	cp -r build/binaries/java_pluginExecutable/* /usr/local/bin/

COPY build.sh /build.sh

CMD ["/build.sh"]
