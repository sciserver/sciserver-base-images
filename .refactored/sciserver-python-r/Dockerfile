FROM sciserver-jupyter

# Python (Anaconda)

RUN conda create -y --name py37 python=3.7 anaconda=2019.07 \
	&& conda clean -y --all \
	&& source activate py37 \
	&& python -m ipykernel install --user --name py37 --display-name "Python 3.7 (py37)" \
	&& /bin/bash -c 'printf "source activate py37\n" >> ~/.bashrc'


# R

USER root

RUN yum -y install epel-release \
	&& yum -y install \
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
	&& yum clean all \
	&& rm -rf /var/cache/yum

USER idies

ARG R_VERSION=3.6.1

RUN curl -L https://cran.rstudio.com/src/base/R-3/R-$R_VERSION.tar.gz -o R.tar.gz \
	&& tar -xzf R.tar.gz \
	&& cd R-$R_VERSION \
	&& ./configure --prefix=/home/idies/R --enable-R-shlib --with-x=no \
	&& make -j`nproc` \
	&& make install \
	&& cd .. \
	&& rm -rf R.tar.gz R-$R_VERSION

RUN cd ~/R/bin \
	&& ./Rscript -e "install.packages(c('Cairo', 'IRkernel'), repos='https://cloud.r-project.org/')" \
	&& ./Rscript -e "IRkernel::installspec(displayname = 'R $R_VERSION')"

RUN /bin/bash -c $'printf "options(bitmapType=\'cairo\')\n" >> ~/.Rprofile'
