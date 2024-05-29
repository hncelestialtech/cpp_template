FROM centos:7
#RUN microdnf install -y yum
RUN yum -y install epel-release
RUN yum -y install ninja-build

RUN yum -y install wget

RUN yum -y install centos-release-scl-rh
RUN yum -y install devtoolset-11
RUN yum -y install python3-devel
RUN pip3 install conan
RUN yum -y install gcc gcc-c++ openssl openssl-devel
RUN wget https://github.com/Kitware/CMake/releases/download/v3.23.0/cmake-3.23.0.tar.gz
RUN tar -xvzf cmake-3.23.0.tar.gz
WORKDIR /cmake-3.23.0
RUN ./bootstrap && make -j4 && make install

