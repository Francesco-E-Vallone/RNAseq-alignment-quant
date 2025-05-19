FROM ubuntu:22.04

#installing dependencies
RUN apt-get update && apt-get install -y \
    wget \
    bash \
    unzip \
    gzip \
    tar \
    make \
    gcc \
    g++ \
    zlib1g-dev \
    libncurses5-dev \
    libbz2-dev \
    liblzma-dev \
    curl \
    git \
    default-jdk \
    python3 \
    python3-pip \
    bamtools \
    libboost-all-dev \
    libssl-dev \
    samtools \
    libcurl4-gnutls-dev \
    htop \
    xxd \
    && rm -rf /var/lib/apt/lists/*


#installing STAR (precompiled binary)
RUN wget https://github.com/alexdobin/STAR/archive/2.7.11b.tar.gz && \
    tar -xzf 2.7.11b.tar.gz && \
    cd STAR-2.7.11b/source && \
    sed -i 's/-mavx2//g' Makefile && \
    make STAR && \
    cp STAR /usr/local/bin/ && \
    cd / && \
    rm -rf STAR-2.7.11b* 2.7.11b.tar.gz

#installing featureCounts
RUN wget https://downloads.sourceforge.net/project/subread/subread-2.0.6/subread-2.0.6-Linux-x86_64.tar.gz && \
    tar -xzf subread-2.0.6-Linux-x86_64.tar.gz && \
    cp subread-2.0.6-Linux-x86_64/bin/featureCounts /usr/local/bin/ && \
    rm -rf subread-2.0.6*

#setting workdir
WORKDIR /data

CMD ["bash"]