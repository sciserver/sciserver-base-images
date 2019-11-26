FROM sciserver-base

RUN yum -y install perl-Digest-MD5

RUN mkdir /opt/texlive \
	&& cd /opt/texlive \
	&& /bin/bash -c 'printf "selected_scheme scheme-full\nTEXDIR /usr/local/texlive\n" >> texlive.profile' \
	&& curl -L http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz -o texlive.tar.gz \
	&& tar -xzf texlive.tar.gz --strip 1 \
	&& ./install-tl --profile texlive.profile \
	&& cd .. \
	&& rm -rf /opt/texlive

ENV PATH /usr/local/texlive/bin/x86_64-linux:$PATH

RUN	yum -y install fontconfig fontconfig-devel \
	&& yum clean all \
	&& rm -rf /var/cache/yum
