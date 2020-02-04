FROM sciserver-jupyter

# Python (Anaconda)

RUN conda create -y --name py37 python=3.7 anaconda=2019.10 \
	&& conda clean -y --all \
	&& source activate py37 \
	&& python -m ipykernel install --user --name py37 --display-name "Python 3.7 (py37)" \
	&& /bin/bash -c 'printf "source activate py37\n" >> ~/.bashrc'


# R

USER root

RUN yum -y install epel-release \
	&& yum config-manager --set-enabled PowerTools \
	&& yum -y install \
		gcc-gfortran \
		zeromq-devel \
		zlib-devel \
		readline-devel \
		bzip2-devel \
		xz-devel \
		pcre-devel \
		openssl-devel \
		libcurl-devel \
		libpng-devel \
		libtiff-devel \
		libjpeg-devel \
		cairo-devel \
		libXt-devel \
		texinfo \
		pandoc \
		glibc-locale-source \
		glibc-langpack-en \
	&& yum clean all \
	&& rm -rf /var/cache/yum

USER idies

ARG R_VERSION=3.6.2

RUN curl -L https://cran.rstudio.com/src/base/R-3/R-$R_VERSION.tar.gz -o R.tar.gz \
	&& tar -xzf R.tar.gz \
	&& cd R-$R_VERSION \
	&& ./configure --prefix=/home/idies/R --enable-R-shlib --with-x=no \
	&& make -j`nproc` \
	&& make install \
	&& cd .. \
	&& rm -rf R.tar.gz R-$R_VERSION

ENV PATH /home/idies/R/bin:$PATH

RUN Rscript -e "install.packages(c('Cairo', 'IRkernel'), repos='https://cloud.r-project.org/')" \
	&& Rscript -e "IRkernel::installspec(displayname = 'R $R_VERSION')" \
	&& /bin/bash -c $'printf "options(bitmapType=\'cairo\')\n" >> ~/.Rprofile'


# SciScript Python

RUN conda install -y \
		argcomplete \
		chest \
		configobj \
		dill \
		redis \
		redis-py \
		sphinx_rtd_theme \
		traceback2 \
		unittest2 \
	&& conda install -y -c anaconda \
		libdynd \
		dynd-python \
	&& conda install -y -c conda-forge \
		grequests \
	&& conda clean -y --all

RUN git clone https://github.com/sciserver/SciScript-Python.git \
	&& touch /home/idies/keystone.token \
	&& (cd /home/idies/SciScript-Python \
	&&     git checkout sciserver-v2.0.13 \
	&&     cd py3 && python setup.py install) \
	&& rm /home/idies/keystone.token


# SciScript R

RUN Rscript -e "install.packages(c('bit64', 'jpeg', 'httr', 'jsonlite', 'data.table'), repos='https://cloud.r-project.org/')"

RUN git clone https://github.com/sciserver/SciScript-R.git \
	&& touch /home/idies/keystone.token \
	&& (cd /home/idies/SciScript-R \
	&&     git checkout sciserver-v2.0.13 \
	&&     cd .. \
	&&     R CMD build SciScript-R \
	&&     R CMD INSTALL SciServer*.tar.gz) \
	&& rm -rf /home/idies/SciServer*.tar.gz \
	&& rm /home/idies/keystone.token
