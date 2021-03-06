FROM debian:jessie
LABEL Description="A STARTPAGE CLONED AND EDITED FROM LIVID" Vendor="JustZht Products" Version="1.0"
MAINTAINER JustZht <zhtsu47@me.com>

RUN echo yo here we begin
RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62
RUN echo "deb http://nginx.org/packages/mainline/debian/ jessie nginx" >> /etc/apt/sources.list

ENV NGINX_VERSION 1.9.0-1~jessie

RUN apt-get update && \
    apt-get install -y ca-certificates nginx && \
    rm -rf /var/lib/apt/lists/*

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

VOLUME ["/var/cache/nginx"]

COPY . /usr/share/nginx/html

ADD default /etc/nginx/sites-available/default
ADD default /etc/nginx/default

VOLUME /usr/share/nginx/html
VOLUME /etc/nginx

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
