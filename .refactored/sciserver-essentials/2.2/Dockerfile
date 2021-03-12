FROM dockerregistry:443/sciserver-essentials:2.1

USER root
RUN dnf -y install mesa-libGL mesa-libGL-devel \
		&& dnf clean all \
		&& rm -rf /var/cache/yum
USER idies
