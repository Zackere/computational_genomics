# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.224.3/containers/ubuntu/.devcontainer/base.Dockerfile

# [Choice] Ubuntu version (use hirsuite or bionic on local arm64/Apple Silicon): hirsute, focal, bionic
ARG VARIANT="hirsute"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive && \
    apt-get -y install --no-install-recommends \
    build-essential git wget libssl-dev \
    p7zip-full zlib1g-dev libncurses5-dev libbz2-dev \
    liblzma-dev libcurl3-dev libx11-xcb-dev libxft-dev \
    libreadline-dev cmake openjdk-8-jdk libnet-ssleay-perl \
    libio-socket-ssl-perl libgd-graph-perl libgd-tools libgd-dev

RUN cpan install CPAN && \
    cpan install CPAN::DistnameInfo && \
    cpan install Statistics::Descriptive && \
    cpan install Net::SSLeay && \
    cpan install IO::Socket::SSL && \
    cpan install GD::Graph::histogram

# ROOT
WORKDIR /ROOT
ENV ROOTSYS /ROOT/root
ENV LD_LIBRARY_PATH /ROOT/root/lib
RUN wget https://root.cern/download/root_v6.16.00.Linux-ubuntu18-x86_64-gcc7.3.tar.gz && \
    tar xfz root_v6.16.00.Linux-ubuntu18-x86_64-gcc7.3.tar.gz

# samtools
WORKDIR /samtools
RUN wget https://github.com/samtools/samtools/releases/download/1.11/samtools-1.11.tar.bz2 && \
    tar xjf samtools-1.11.tar.bz2 && \
    rm samtools-1.11.tar.bz2 && \
    cd samtools-1.11 && \
    ./configure --prefix /samtools/samtools-1.11 && \
    make && \
    ln -s /samtools/samtools-1.11/samtools /usr/bin/samtools

# CNVNator
WORKDIR /cnvnator
ENV PATH="${PATH}:/cnvnator/CNVnator/"

RUN git clone https://github.com/abyzovlab/CNVnator.git && \
    cd CNVnator && \
    ln -s /samtools/samtools-1.11 samtools && \
    make LIBS="-lcrypto"

# Breakdancer
WORKDIR /
RUN git clone --recursive https://github.com/genome/breakdancer.git && \
    cd breakdancer && \
    mkdir build && \
    cd build && \
    cmake .. -DCMAKE_BUILD_TYPE=release -DCMAKE_INSTALL_PREFIX=/usr/local && \
    make && \
    make install

# Bwa
WORKDIR /
RUN wget https://netcologne.dl.sourceforge.net/project/bio-bwa/bwa-0.7.17.tar.bz2 && \
    tar xjf bwa-0.7.17.tar.bz2 && \
    cd bwa-0.7.17 && \
    make && \
    ln -s /bwa-0.7.17/bwa /usr/bin/bwa

# Biobambam
WORKDIR /
ENV PATH="${PATH}:/biobambam2/2.0.87-release-20180301132713/x86_64-etch-linux-gnu/bin"
RUN wget https://github.com/gt1/biobambam2/releases/download/2.0.87-release-20180301132713/biobambam2-2.0.87-release-20180301132713-x86_64-etch-linux-gnu.tar.gz && \
    tar xzf biobambam2-2.0.87-release-20180301132713-x86_64-etch-linux-gnu.tar.gz

# Delly
WORKDIR /delly
RUN wget https://github.com/dellytools/delly/releases/download/v0.8.7/delly_v0.8.7_linux_x86_64bit && \
    chmod a+x delly_v0.8.7_linux_x86_64bit && \
    ln -s /delly/delly_v0.8.7_linux_x86_64bit /usr/bin/delly

# bcftools
WORKDIR /bcftools
RUN wget https://github.com/samtools/bcftools/releases/download/1.11/bcftools-1.11.tar.bz2 && \
    tar xjf bcftools-1.11.tar.bz2 && \
    cd bcftools-1.11 && \
    make && \
    ln -s /bcftools/bcftools-1.11/bcftools /usr/bin/bcftools
