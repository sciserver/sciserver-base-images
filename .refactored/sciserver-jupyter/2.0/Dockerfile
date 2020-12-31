FROM dockerregistry:443/sciserver-base-texlive

EXPOSE 8888

COPY startup.sh /opt/startup.sh

USER idies

WORKDIR /home/idies

RUN curl -L https://repo.anaconda.com/miniconda/Miniconda3-py38_4.9.2-Linux-x86_64.sh -o miniconda.sh \
	&& bash miniconda.sh -b \
	&& rm -f miniconda.sh

ENV PATH /home/idies/miniconda3/bin:$PATH

RUN conda update -y conda \
	&& conda update -y --all \
	&& conda install -y -c conda-forge jupyter==1.0.0 jupyterlab==2.2.6 \
	&& conda clean -y --all \
	&& jupyter kernelspec remove -f python3
