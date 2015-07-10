FROM mhasa004/ubuntu14.04-cuda7.0-torch7:latest
MAINTAINER Mahmudul Hasan <mhasa004@ucr.edu>

# install dependencies
RUN apt-get -y install libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev
RUN apt-get -y install --no-install-recommends libboost-all-dev
RUN apt-get -y install libatlas-base-dev
RUN apt-get -y install python-dev
RUN apt-get -y install libgflags-dev libgoogle-glog-dev liblmdb-dev protobuf-compiler
RUN apt-get -y install libjpeg62 libfreeimage-dev pkgconf python-pip unzip 

# clone caffe from github
RUN cd /opt && git clone https://github.com/BVLC/caffe.git

# build caffe
RUN cd /opt/caffe && cp Makefile.config.example Makefile.config && make all

# Add caffe binaries to path
ENV PATH=$PATH:/opt/caffe/.build_release/tools
ADD caffe-ld-so.conf /etc/ld.so.conf.d/
RUN ldconfig

# make + runtest
RUN cd /opt/caffe && make test && make runtest
