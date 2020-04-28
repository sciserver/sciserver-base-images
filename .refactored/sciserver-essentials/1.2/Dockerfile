FROM sciserver-essentials:1.1-geo

USER root

RUN yum -y install gtk3 dbus-glib \
	&& yum clean all \
	&& rm -rf /var/cache/yum

RUN cd /opt \
	&& wget http://ftp.mozilla.org/pub/firefox/releases/75.0/linux-x86_64/en-US/firefox-75.0.tar.bz2 \
	&& tar xjf firefox-75.0.tar.bz2 \
	&& ln -s /opt/firefox/firefox /usr/bin/firefox \
	&& rm -f /opt/firefox-75.0.tar.bz2

RUN cd /opt \
	&& wget https://github.com/mozilla/geckodriver/releases/download/v0.26.0/geckodriver-v0.26.0-linux64.tar.gz \
	&& tar xzf geckodriver-v0.26.0-linux64.tar.gz \
	&& ln -s /opt/geckodriver /usr/bin/geckodriver \
	&& rm -f /opt/geckodriver-v0.26.0-linux64.tar.gz

USER idies

RUN conda install -y -n py37 -c conda-forge selenium \
	&& conda clean -y --all
