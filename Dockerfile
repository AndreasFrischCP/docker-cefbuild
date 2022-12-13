FROM ubuntu:18.04

ENV CHROMIUM_VERSION 104.0.5112.81
ENV CHROMIUM_BRANCH 5112
ENV CEF_ARCHIVE_FORMAT tar.bz2
ENV CEF_USE_GN 1
# To avoid bricked workspaces (https://github.com/gitpod-io/gitpod/issues/1171)
ARG DEBIAN_FRONTEND=noninteractive

USER root
WORKDIR /usr/build/code
SHELL ["/bin/bash", "-c"]

RUN mkdir chromium_git/ && \
    mkdir automate && \
    mkdir scripts && \
    mkdir build-artifacts

RUN apt-get update -qq
RUN apt-get full-upgrade -y
RUN apt-get install -y \
        build-essential \
        chromium-codecs-ffmpeg-extra \
        ninja-build \
        curl \
        ffmpeg \
        git \
        libva-dev  \
        libx264-152 \
        lsb-release \
        python \
        python-pkg-resources \
        python3-pip \
        sudo
RUN apt-get purge -y --auto-remove
RUN pip3 install importlib-metadata

RUN curl "https://chromium.googlesource.com/chromium/src/+/refs/tags/${CHROMIUM_VERSION}/build/install-build-deps.sh?format=TEXT" | base64 -d > install-build-deps.sh && \
    chmod 755 install-build-deps.sh
RUN ./install-build-deps.sh --no-chromeos-fonts --no-nacl --no-prompt

RUN git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git

RUN curl https://bitbucket.org/chromiumembedded/cef/raw/master/tools/automate/automate-git.py -o automate/automate-git.py

COPY patches patches/
COPY scripts/update.sh scripts/

RUN scripts/update.sh

COPY scripts/build.sh scripts/
RUN scripts/build.sh

CMD cp chromium_git/chromium/src/cef/binary_distrib/cef_binary_*_linux64_minimal.tar.bz2 build-artifacts/
