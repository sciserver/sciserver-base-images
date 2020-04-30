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

RUN curl -L https://mirror.oxfordnanoportal.com/software/analysis/ont_guppy_3.5.2-1~xenial_amd64.deb -o ont_guppy.deb \
	&& dpkg -i --ignore-depends=nvidia-384,libcuda1-384 ont_guppy.deb || true \
	&& apt-get -y -f install \
	&& apt-get -y clean \
	&& rm -f ont_guppy.deb

USER idies
