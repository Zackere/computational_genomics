# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.224.3/containers/ubuntu/.devcontainer/base.Dockerfile

# [Choice] Ubuntu version (use hirsuite or bionic on local arm64/Apple Silicon): hirsute, focal, bionic
ARG VARIANT="hirsute"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive && \
    apt-get -y install --no-install-recommends build-essential git wget libcurl4-openssl-dev p7zip-full zlib1g-dev libncurses5-dev libbz2-dev liblzma-dev libcurl3-dev libx11-xcb-dev libxft-dev libreadline-dev cmake openjdk-8-jdk

# CNVNator
WORKDIR /cnvnator
ENV ROOTSYS /cnvnator/root
ENV LD_LIBRARY_PATH /cnvnator/root/lib
ENV PATH="${PATH}:/cnvnator/CNVnator/"

RUN wget https://root.cern/download/root_v6.16.00.Linux-ubuntu18-x86_64-gcc7.3.tar.gz && \
    tar xfz root_v6.16.00.Linux-ubuntu18-x86_64-gcc7.3.tar.gz && \
	rm root_v6.16.00.Linux-ubuntu18-x86_64-gcc7.3.tar.gz && \
    wget https://github.com/samtools/samtools/releases/download/1.11/samtools-1.11.tar.bz2 && \
	tar -xjf samtools-1.11.tar.bz2 && \
	rm samtools-1.11.tar.bz2 && \
	cd samtools-1.11 && \
	./configure --prefix /cnvnator/samtools-1.11 && \
	make && \
	ln -s /cnvnator/samtools-1.11/samtools /usr/bin/samtools && \
    git clone https://github.com/abyzovlab/CNVnator.git && \
	cd CNVnator && \
	ln -s /cnvnator/samtools-1.11 samtools && \
	make

# Breakdancer
WORKDIR /
RUN git clone --recursive https://github.com/genome/breakdancer.git && \
	cd breakdancer && \
	mkdir build && \
	cd build && \
	cmake .. -DCMAKE_BUILD_TYPE=release -DCMAKE_INSTALL_PREFIX=/usr/local && \
	make && \
	make install
