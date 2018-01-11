FROM ubuntu:14.04

MAINTAINER Mike Splain <mike.splain@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# Default http protocol
ENV HTTP_PROTOCOL http

RUN apt-get update && \
    apt-get -o Dpkg::Options::='--force-confold' --force-yes -fuy dist-upgrade

RUN apt-get update && \
    apt-get install nginx sed dnsutils -yq

# apt clean
RUN apt-get clean &&\
  rm -rf /var/lib/apt/lists/* &&\
  rm -rf /tmp/*

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

RUN rm -rf /etc/nginx/sites-enabled/default
ADD default /etc/nginx/sites-enabled/default
ADD start.sh /start.sh
RUN chmod 700 /start.sh

EXPOSE 80

CMD ["./start.sh"]
