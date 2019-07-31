ARG PARENT_IMAGE=dockerregistry:443/miniconda:latest
FROM $PARENT_IMAGE

RUN wget -nv https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
	&& yum -y install epel-release-latest-7.noarch.rpm \
	&& rm epel-release-latest-7.noarch.rpm \
	&& yum install -y \
		# installed for R packages (particularly shapefile-related)
		udunits2-devel \
	&& yum clean all \
	&& rm -rf /var/cache/yum

USER idies

WORKDIR /home/idies

COPY --chown=idies Rprofile /home/idies/.Rprofile

RUN conda update -y -n base conda \
  && conda install -y anaconda=2018.12 \
  && conda create -y -n py27 anaconda=2018.12 python=2.7 \
  # Add channels
  && conda config --add channels conda-forge \
  # Update existing package
  && conda update -y --all \
  && conda update -n py27 -y --all \
  # Setup python3 and R
  && conda install -y \
	argcomplete \
	chest \
	configobj \
	dill \
	dynd-python \
	grequests \
	libdynd \
	python=3.7 \
	redis \
	redis-py \
	sphinx_rtd_theme \
	traceback2 \
	unittest2 \
	r-bit64 \
	r-essentials=3.5 \
	r-jpeg \
  && conda update -y --all \
  && pip install --no-cache-dir \
  	gatspy \
	# pymc/pymc3 in conda repo do not support python3.7+ at this time
	pymc \
	pymc3 \
	sockjs-tornado \
	supersmoother \
  # Setup python2
  && conda install -y -n py27 \
	argcomplete \
	chest \
	configobj \
	dill \
	dynd-python \
	grequests \
	ipykernel \
	libdynd \
	pymc \
	pymc3 \
	redis \
	redis-py \
	sphinx_rtd_theme \
	traceback2 \
	unittest2 \
  # && conda update -n py27 -yv --all \
  && (source activate py27 && pip install --no-cache-dir \
  	gatspy \
	supersmoother \
	sockjs-tornado ) \
  && jupyter lab build \
  && (source activate py27 && python -m ipykernel install --user) \
  && conda clean -y --all

# SciScript-Python and SciScript-R

RUN git clone https://github.com/sciserver/SciScript-Python.git && \
	git clone https://github.com/sciserver/SciScript-R.git && \
	touch /home/idies/keystone.token && \
	(cd /home/idies/SciScript-Python && \
		git checkout sciserver-v2.0.13 && \
		(cd py3 && python setup.py install) && \
		(source activate py27 && cd py2 && python setup.py install)) && \
	(cd /home/idies/SciScript-R && \
		git checkout sciserver-v2.0.13 && \
		cd .. && \
		R CMD build SciScript-R && \
		R CMD INSTALL SciServer*.tar.gz) && \
	rm -rf /home/idies/SciServer*.tar.gz && \
	rm /home/idies/keystone.token

USER root
