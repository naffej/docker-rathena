FROM debian:10

COPY ./install.sh /install.sh
RUN apt-get update && \
    apt-get install -y --no-install-recommends mc git build-essential zlib1g-dev net-tools libpcre3-dev default-libmysqlclient-dev default-mysql-server supervisor

RUN apt-get install -y systemd
ENV TZ=Europe/Budapest
RUN ln -snf /usr/share/zoneinfo/Europe/Budapest /etc/localtime && echo Europe/Budapest > /etc/timezone

RUN sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf
ADD .build/supervisor/supervisord.conf /etc/supervisor/supervisord.conf
ADD .build/supervisor/supervisord.conf /etc/supervisord.conf
RUN mkdir -p /var/run/supervisor
RUN mkdir -p /var/log/supervisord
CMD ["/usr/bin/supervisord","-c","/etc/supervisord.conf"]