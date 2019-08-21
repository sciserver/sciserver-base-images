FROM sciserver-base-texlive

USER idies

WORKDIR /home/idies

RUN curl -L https://repo.anaconda.com/miniconda/Miniconda3-4.7.10-Linux-x86_64.sh -o miniconda.sh \
	&& bash miniconda.sh -b \
	&& rm -f miniconda.sh

ENV PATH /home/idies/miniconda3/bin:$PATH

RUN conda update -y conda \
	&& conda update -y --all \
	&& conda install -y -c conda-forge jupyter==1.0.0 jupyterlab==1.0.5 \
	&& conda clean -y --all \
	&& jupyter kernelspec remove -f python3

COPY entrypoint.sh /etc/entrypoint.sh

ENTRYPOINT /etc/entrypoint.sh

EXPOSE 8888
