FROM shixiangwang/gistic:latest
MAINTAINER xuefei <710681482@qq.com>

COPY data.zip /opt/GISTIC
RUN cd /opt/GISTIC && unzip data.zip
RUN mv /opt/GISTIC/data/run_gistic.sh /opt/GISTIC
RUN mv /opt/GISTIC/data/gistic_cnv.py /usr/bin

# Python
RUN pip install --upgrade pip -i https://pypi.tuna.tsinghua.edu.cn/simple
RUN pip install HTSeq  -i https://pypi.tuna.tsinghua.edu.cn/simple

# Rscrip
RUN conda install -y r-base=3.6.1
