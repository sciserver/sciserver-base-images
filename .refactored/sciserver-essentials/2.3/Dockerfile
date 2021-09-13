FROM dockerregistry:443/sciserver-essentials:2.2

USER root
RUN dnf -y install poppler-cpp-devel \
	&& dnf clean all \
	&& rm -rf /var/cache/yum
USER idies
