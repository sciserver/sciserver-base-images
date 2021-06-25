FROM ubuntu:focal

ARG S6_VER="2.2.0.3"
ARG NO_VNC_VER="1.2.0"
ARG WEB_SOCK_VER="0.9.0"

RUN mkdir /_install


ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_VER}/s6-overlay-amd64.tar.gz /_install
RUN tar xzf /_install/s6-overlay-amd64.tar.gz -C / --exclude="./bin" && \
    tar xzf /_install/s6-overlay-amd64.tar.gz -C /usr ./bin


ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && \
    apt upgrade -y && \
    apt install -y plasma-desktop dbus-x11


RUN apt install -y dolphin konsole


RUN apt install -y tigervnc-standalone-server tigervnc-xorg-extension
ENV DISPLAY=:0 \
    SCR_WIDTH=1600 \
    SCR_HEIGHT=900


ADD https://github.com/novnc/noVNC/archive/v${NO_VNC_VER}.zip /_install
ADD https://github.com/novnc/websockify/archive/v${WEB_SOCK_VER}.zip /_install
RUN cd /_install && \
    apt install -y unzip nginx && \
    unzip v${NO_VNC_VER}.zip && \
    unzip v${WEB_SOCK_VER}.zip && \
    mv noVNC-${NO_VNC_VER} /novnc && \
    mv websockify-${WEB_SOCK_VER} /novnc/utils/websockify
ENV PATH_PREFIX=/ \
    VNC_RESIZE=scale \
    RECON_DELAY=250 \
    PAGE_TITLE=KDE


ENV PGID=1000 \
    PUID=1000 \
    ROOT_PASSWORD=password \
    HOME=/home/idies
RUN useradd -U -u 1000 -m -d "$HOME" --shell /bin/bash idies


WORKDIR /


COPY root /


RUN apt autoremove -y && \
    apt clean && \
    rm -r /_install


COPY startup.sh /opt/startup.sh
RUN apt install -y \
    binutils \
    wget \
    git \
    vim \
    fonts-liberation \
    kate \
    firefox \
    openjdk-8-jdk


USER idies
RUN mkdir -p $HOME/workspace
RUN cd $HOME \
    && wget -O Miniconda-install.sh -nv https://repo.anaconda.com/miniconda/Miniconda3-py38_4.9.2-Linux-x86_64.sh \
    && bash Miniconda-install.sh -b \
    && rm Miniconda-install.sh
ENV PATH /home/idies/miniconda3/bin:$PATH
RUN conda install -y numpy
USER root


# https://stackoverflow.com/a/65564226
RUN strip --remove-section=.note.ABI-tag /usr/lib/x86_64-linux-gnu/libQt5Core.so.5

EXPOSE 8888
