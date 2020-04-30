FROM nvidia/cuda:10.2-base-ubuntu16.04


RUN useradd idies \
	&& mkdir -p /home/idies/workspace \
	&& chown -R idies:idies /home/idies

RUN apt-get -y update \
	&& apt-get -y install \
		build-essential \
		curl \
		wget \
		git \
	&& apt-get -y clean

EXPOSE 8888

COPY startup.sh /opt/startup.sh

USER idies

WORKDIR /home/idies

RUN curl -L https://repo.anaconda.com/miniconda/Miniconda3-py37_4.8.2-Linux-x86_64.sh -o miniconda.sh \
	&& bash miniconda.sh -b \
	&& rm -f miniconda.sh

ENV PATH /home/idies/miniconda3/bin:$PATH

RUN conda update -y conda \
	&& conda update -y --all \
	&& conda install -y -c conda-forge jupyter==1.0.0 jupyterlab==2.1.1 \
	&& conda clean -y --all \
	&& jupyter kernelspec remove -f python3


# Guppy

USER root

RUN apt-get -y install wget lsb-release \
	&& export PLATFORM=$(lsb_release -cs) \
	&& wget -O- https://mirror.oxfordnanoportal.com/apt/ont-repo.pub | apt-key add - \
	&& echo "deb http://mirror.oxfordnanoportal.com/apt ${PLATFORM}-stable non-free" | tee /etc/apt/sources.list.d/nanoporetech.sources.list \
	&& apt-get -y update \
	&& apt-get -y clean

RUN apt-get -y install ont-guppy --no-install-recommends \
	&& apt-get -y clean

USER idies
