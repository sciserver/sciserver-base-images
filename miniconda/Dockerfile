ARG PARENT_IMAGE=dockerregistry:443/idies:latest
FROM $PARENT_IMAGE
EXPOSE 8888

USER idies
WORKDIR /home/idies

RUN wget -O Miniconda-install.sh -nv https://repo.anaconda.com/miniconda/Miniconda3-4.5.12-Linux-x86_64.sh \
	&& bash Miniconda-install.sh -b \
	&& rm Miniconda-install.sh

ENV PATH /home/idies/miniconda3/bin:$PATH

RUN conda update -y -n base conda \
  && conda update -y --all \
  && conda install -y jupyter jupyterlab nodejs \
  && conda install -y -c sciserver nb_sciserver=0.1.1 \
  && conda update -y --all \
  && jupyter labextension install nb_sciserver_lab@0.1.2 \
  && conda clean -y --all

USER root

COPY jupyter_notebook_config.py /home/idies/.jupyter/jupyter_notebook_config.py
RUN chown idies -R /home/idies/.jupyter

COPY startup.sh /opt/startup.sh
