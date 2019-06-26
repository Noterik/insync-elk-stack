# Dockerfile to illustrate how Filebeat can be used with nginx
# Filebeat 7.0.1

# Build with:
# docker build -t filebeat-nginx-example .

# Run with:
# docker run -p 80:80 -it --link <elk-container-name>:elk \
#     --name filebeat-nginx-example filebeat-nginx-example

FROM ubuntu:latest
MAINTAINER David Ammeraal


###############################################################################
#                                INSTALLATION
###############################################################################

### install Filebeat

ENV FILEBEAT_VERSION 7.0.1


RUN apt-get update -qq \
  && apt-get install -qqy curl vim \
  && apt-get clean

RUN curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${FILEBEAT_VERSION}-amd64.deb \
  && dpkg -i filebeat-${FILEBEAT_VERSION}-amd64.deb \
  && rm filebeat-${FILEBEAT_VERSION}-amd64.deb


###############################################################################
#                                CONFIGURATION
###############################################################################

# config file
ADD filebeat.yml /etc/filebeat/filebeat.yml
RUN chmod 644 /etc/filebeat/filebeat.yml

# CA cert
RUN mkdir -p /etc/pki/tls/certs
ADD logstash-beats.crt /etc/pki/tls/certs/logstash-beats.crt

RUN touch /var/log/test.log

# create template based on filebeat version (assumption: it is the same version as elasticsearch version)
RUN filebeat export template --es.version ${FILEBEAT_VERSION} > /etc/filebeat/filebeat.template.json

ADD ./start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh
CMD [ "/usr/local/bin/start.sh" ]