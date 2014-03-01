FROM centos
MAINTAINER Niek Bartholomeus "niek.bartholomeus@gmail.com"

RUN yum install -y postgresql-server postgresql

RUN echo "NETWORKING=yes" > /etc/sysconfig/network

ADD . /

ENV ADMIN_PASSWORD !!ChangeMe!!

RUN /source-files/createdatabase.sh

RUN mkdir /data
VOLUME ["/data"]

CMD ["/source-files/start.sh"]