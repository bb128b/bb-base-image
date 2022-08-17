FROM centos:7.9.2009

RUN sed 's/enabled=1/enabled=0/g' -i /etc/yum/pluginconf.d/fastestmirror.conf

# start workaround for 16.17 on centos
# RUN curl -sL https://rpm.nodesource.com/setup_16.16 | bash -
ENV NODE_VERSION "16.17.0"
RUN curl -o node-v$NODE_VERSION-linux-x64.tar.xz https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz
RUN xz -d node-v$NODE_VERSION-linux-x64.tar.xz
RUN tar xvf node-v$NODE_VERSION-linux-x64.tar
RUN mv node-v$NODE_VERSION-linux-x64 /usr/local/nodejs
ENV PATH="${PATH}:/usr/local/nodejs/bin"
# end workaround

RUN yum update -y -q && \
  yum install -y -q gettext && \
  yum clean all && \
  rm -r /var/cache/yum

RUN yum -y install python3 npm unixODBC unixODBC-devel
