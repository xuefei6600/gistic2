FROM debian:latest
MAINTAINER xuefei <710681482@qq.com>
RUN apt-get update --fix-missing
RUN apt-get install -qq -y zip wget
RUN apt-get install -y build-essential
RUN apt-get install -y libxt6 libxmu6
## GISTIC install
RUN mkdir /GISTIC
#COPY GISTIC_2_0_23.tar.gz /GISTIC
RUN cd /GISTIC && wget -c ftp://ftp.broadinstitute.org/pub/GISTIC2.0/GISTIC_2_0_23.tar.gz
## RUN cd /GISTIC && tar -zxvf /GISTIC/GISTIC_2_0_23.tar.gz
RUN cd /GISTIC/MCR_Installer && unzip MCRInstaller.zip
RUN /GISTIC/MCR_Installer/install -mode silent -agreeToLicense yes -destinationFolder /GISTIC/MATLAB_Compiler_Runtime
RUN rm -f /GISTIC/GISTIC_2_0_23.tar.gz
## analysis script install
COPY data.zip /GISTIC
RUN cd /GISTIC && unzip data.zip
RUN mv /GISTIC/data/run_gistic.sh /GISTIC
RUN mv /GISTIC/data/gistic_cnv.py /usr/bin
RUN rm -f /GISTIC/data.zip
## miniconda2 install
RUN cd / && wget -c https://repo.anaconda.com/miniconda/Miniconda2-latest-Linux-x86_64.sh
RUN /bin/bash /Miniconda2-latest-Linux-x86_64.sh -b -p /miniconda2
RUN /miniconda2/bin/conda install -y python=2.7 r-base=3.6
RUN /miniconda2/bin/pip install HTSeq  -i https://pypi.tuna.tsinghua.edu.cn/simple
RUN /miniconda2/bin/conda clean -all -y
RUN rm -f /Miniconda2-latest-Linux-x86_64.sh
## clean
RUN apt-get -qq -y remove zip
# RUN apt-get -qq -y autoremove
# RUN apt-get autoclean
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*
