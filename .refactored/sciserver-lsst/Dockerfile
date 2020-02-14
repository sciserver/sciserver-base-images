FROM sciserver-base-texlive:latest

EXPOSE 8888

ENV SHELL=/bin/bash \
	HOME=/home/idies

RUN printf "\nfastestmirror=True" >> /etc/dnf/dnf.conf
RUN yum update -y && yum install -y \
		blas bison bzip2 bzip2-devel \
		cmake curl \
		flex fontconfig freetype-devel \
		gcc-c++ gcc-gfortran gettext glib2-devel \
		java \
		libXext libXrender libXt-devel libcurl-devel libuuid-devel \
		make \
		ncurses-devel \
		openssl-devel \
		patch perl perl-ExtUtils-MakeMaker \
		readline-devel \
		which \
		zlib-devel \
		git \
	&& yum clean all \
	&& rm -rf /var/cache/yum

USER idies

# create lsst base dir and install lsst there
RUN mkdir -p /home/idies/lsst
WORKDIR /home/idies/lsst/
RUN curl -OL https://raw.githubusercontent.com/lsst/lsst/19.0.0/scripts/newinstall.sh \
	&& chmod +x newinstall.sh \
	&& bash ./newinstall.sh -bt \
	&& rm ./newinstall.sh

USER root
RUN yum -y install rsync \
	&& yum clean all \
	&& rm -rf /var/cache/yum
USER idies

# install sims_maf
RUN /bin/bash -c 'source ~/lsst/loadLSST.bash \
	&& chmod a+wr $HOME/.eups \
	&& eups distrib install lsst_sims -t sims_w_2020_06'

# install jupyter
RUN /bin/bash -c 'source ~/lsst/loadLSST.bash \
	&& conda install -y jupyter'

WORKDIR $HOME

COPY startup.sh /opt/startup.sh


# Link to JupyterLab

COPY --chown=idies lab_extension /home/idies/lab_extension

RUN /bin/bash  -c 'source ~/lsst/loadLSST.bash \
	&& pip install jupyterlab==1.2.6 \
	&& jupyter nbextension install /home/idies/lab_extension --user \
	&& jupyter nbextension enable lab_extension/main --user --section="common"'
