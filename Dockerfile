FROM centos:7.9.2009

# Install certificates in Redhat trust root
# COPY hlunixca3.crt /etc/pki/ca-trust/source/anchors/
# RUN /bin/update-ca-trust

# Set UK timezone
RUN ln -snf ../usr/share/zoneinfo/Europe/London /etc/localtime

# Disable fastest mirror plugin
RUN sed 's/enabled=1/enabled=0/g' -i /etc/yum/pluginconf.d/fastestmirror.conf

# Update all installed packages to version in yum snapshot
RUN yum update -y -q && \
    yum install -y -q gettext && \
    yum clean all && \
    rm -r /var/cache/yum

#
# FROM registry.gitlab.com/hldev/devops/base-images/hlbase7-gitlab:latest
#

# start workaround for 16.17 on centos
# RUN curl -sL https://rpm.nodesource.com/setup_16.x | bash -
ENV NODE_VERSION "16.17.0"
RUN curl -o node-v$NODE_VERSION-linux-x64.tar.xz https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz && \
    xz -d node-v$NODE_VERSION-linux-x64.tar.xz && \
    tar xvf node-v$NODE_VERSION-linux-x64.tar && \
    mv node-v$NODE_VERSION-linux-x64 /usr/local/nodejs && \
    rm node-v$NODE_VERSION-linux-x64.tar
ENV PATH="${PATH}:/usr/local/nodejs/bin"
# end workaround

RUN yum update -y && \
    yum -y install centos-release-scl make gcc-c++
RUN yum -y install devtoolset-9 python3 npm unixODBC unixODBC-devel && \
    yum -y clean all && rm -rf /var/cache/yum

RUN echo "source /opt/rh/devtoolset-9/enable" >> /etc/bashrc
SHELL ["/bin/bash", "--login", "-c"]
