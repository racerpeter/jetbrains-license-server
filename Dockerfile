FROM anapsix/alpine-java:8_server-jre
MAINTAINER Peter Fry "https://github.com/racerpeter"

ENV BASE_DIR=/usr/local/license-server
RUN apk add --no-cache curl

RUN /usr/bin/curl -o installer.zip -Ss https://download-cf.jetbrains.com/lcsrv/license-server-installer.zip?version=18692 && \
  mkdir $BASE_DIR && \
  unzip -d $BASE_DIR installer.zip && \
  rm -f installer.zip

COPY docker-launcher.sh /usr/bin/docker-launcher.sh
RUN chmod +x /usr/bin/docker-launcher.sh

EXPOSE 8080

CMD ["/usr/bin/docker-launcher.sh"]
