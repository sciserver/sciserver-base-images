ARG PARENT_IMAGE=scientificlinux/sl:7
FROM $PARENT_IMAGE

RUN useradd idies \
  && mkdir /home/idies/workspace \
  && chown idies:idies /home/idies/workspace \
  && yum -y groupinstall "Development Tools" \
  && yum -y install \
  	bzip2 \
	cmake \
	git \
	# Fonts needed for R
	gnu-free-mono-fonts \
	gnu-free-sans-fonts \
	gnu-free-serif-fonts \
	gsl-devel \
	libSM-devel \
	libXext-devel \
	libXrender-devel \
	mesa-libGL-devel \
	mesa-libGLU \
  	sudo \
	wget \
  # R's Olsen database (and potentially other apps) assume timezone data exists
  # It appears the scientific linux docker image removes /usr/share/zoneinfo
  && yum -y reinstall tzdata \
  && yum clean all \
  && rm -rf /var/cache/yum
