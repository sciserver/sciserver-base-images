FROM dockerregistry:443/sciserver-essentials:2.2

USER root
RUN dnf -y install \
	poppler-cpp-devel \
	tesseract-devel leptonica-devel \
	ImageMagick-c++-devel \
	&& dnf clean all \
	&& rm -rf /var/cache/yum
USER idies
