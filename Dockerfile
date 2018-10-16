FROM tomcat:8.5
MAINTAINER Peter Fry "https://github.com/racerpeter"

ENV BASE_DIR=/usr/local/tomcat/license-server

# The query string param means nothing to the jetbrains server, and is only used to bump the build number in the dockerfile
RUN /usr/bin/curl -o installer.zip https://download-cf.jetbrains.com/lcsrv/license-server-installer.zip?version=17955 && \
  mkdir $BASE_DIR && \
  unzip -d $BASE_DIR installer.zip && \
  rm -f installer.zip

COPY docker-launcher.sh /usr/bin/docker-launcher.sh
RUN chmod +x /usr/bin/docker-launcher.sh

EXPOSE 8080

CMD ["/usr/bin/docker-launcher.sh"]
