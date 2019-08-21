FROM centos:7

RUN useradd idies \
	&& mkdir /home/idies/workspace \
	&& chown idies:idies /home/idies/workspace

RUN yum -y groupinstall "Development Tools" \
	&& yum -y install \
		cmake \
		sudo \
		wget \
		which \
	&& yum clean all \
	&& rm -rf /var/cache/yum
