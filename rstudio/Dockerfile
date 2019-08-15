ARG PARENT_IMAGE=dockerregistry:443/sciserver:latest
FROM $PARENT_IMAGE

RUN yum install -y \
		R \
		nginx \
		libcurl-devel \
		openssl-devel \
	&& wget -nv https://download2.rstudio.org/server/centos6/x86_64/rstudio-server-rhel-1.2.1335-x86_64.rpm \
	&& yum install -y rstudio-server-rhel-*.rpm \
	&& rm rstudio-server-rhel-*.rpm \
	&& yum clean all \
	&& rm -rf /var/cache/yum

USER idies
RUN mkdir -p ~/.rstudio/monitored/user-settings \
	&& echo 'initialWorkingDirectory=~/workspace' > \
		~/.rstudio/monitored/user-settings/user-settings
USER root

COPY rserver.conf /etc/rstudio/rserver.conf
COPY nginx.conf /etc/nginx/nginx.conf
COPY startup.sh /opt/startup.sh
