FROM sciserver-base-texlive

RUN yum -y update
RUN yum -y install epel-release
RUN yum -y install \
                gcc \
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
                libXt-devel

RUN yum config-manager --set-enabled powertools
RUN yum -y install \
                texinfo \
                pandoc \
                glibc-locale-source \
                glibc-langpack-en \
                initscripts

RUN wget -nv https://download2.rstudio.org/server/centos8/x86_64/rstudio-server-rhel-1.4.1103-x86_64.rpm \
        && yum install -y rstudio-server-rhel-*.rpm \
        && rm rstudio-server-rhel-*.rpm \
        && yum clean all \
        && rm -rf /var/cache/yum


ENV PATH /home/idies/R/bin:$PATH

USER idies

ARG R_VERSION=4.0.3

RUN cd ~ \
        && curl -L https://cran.rstudio.com/src/base/R-4/R-$R_VERSION.tar.gz -o R.tar.gz \
        && tar -xzf R.tar.gz \
        && cd R-$R_VERSION \
        && ./configure --prefix=/home/idies/R --enable-R-shlib --with-x=no \
        && make -j`nproc` \
        && make install \
        && cd .. \
        && rm -rf R.tar.gz R-$R_VERSION

RUN Rscript -e "install.packages(c('Cairo'), repos='https://cloud.r-project.org/')"

RUN /bin/bash -c $'printf "options(bitmapType=\'cairo\')\n" >> ~/.Rprofile'


RUN mkdir -p ~/.rstudio/monitored/user-settings \
        && echo 'initialWorkingDirectory=~/workspace' > ~/.rstudio/monitored/user-settings/user-settings

USER root

RUN yum -y install nginx

COPY rserver.conf /etc/rstudio/rserver.conf

COPY nginx.conf /etc/nginx/nginx.conf

COPY entrypoint.sh /etc/entrypoint.sh

COPY --chown=idies Rprofile /home/idies/.Rprofile

## Disabled for compatibility with SciServer
# ENTRYPOINT /etc/entrypoint.sh

EXPOSE 8888


## Added for compatibility with SciServer
COPY entrypoint.sh /opt/startup.sh

RUN yum -y install libxml2-devel

USER idies

WORKDIR /home/idies

RUN wget https://cran.r-project.org/src/contrib/Archive/curl/curl_4.2.tar.gz \
        && R CMD INSTALL curl_4.2.tar.gz \
        && rm curl_4.2.tar.gz \
        && Rscript -e "install.packages(c('httr', 'bit64', 'jpeg', 'jsonlite', 'pbdZMQ', 'repr', 'devtools', 'data.table'))"

RUN Rscript -e "install.packages('tidyverse', Ncpus=`nproc`)"

RUN git clone https://github.com/sciserver/SciScript-R.git \
        && touch /home/idies/keystone.token \
        && (cd /home/idies/SciScript-R \
                && git checkout sciserver-v2.0.13 \
                && cd .. \
                && R CMD build SciScript-R \
                && R CMD INSTALL SciServer*.tar.gz) \
        && rm -rf /home/idies/SciServer*.tar.gz \
        && rm /home/idies/keystone.token



RUN curl -L https://repo.anaconda.com/miniconda/Miniconda3-py38_4.9.2-Linux-x86_64.sh -o miniconda.sh \
        && bash miniconda.sh -b \
        && rm -f miniconda.sh

ENV PATH /home/idies/miniconda3/bin:$PATH

RUN conda update -y conda \
        && conda update -y --all \
        && conda clean -y --all


USER root

#fix bug in the rstudio release
RUN chgrp -R idies /var/lib/rstudio-server/
RUN chmod -R g+rw /var/lib/rstudio-server/

RUN chmod +x /opt/startup.sh