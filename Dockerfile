FROM rockylinux:8-minimal

RUN microdnf install -y yum
RUN microdnf install -y dnf
RUN dnf -y install gcc-toolset-11

RUN yum -y install python3-devel
RUN pip3 install conan --upgrade
RUN yum -y install cmake

# Used by Openssl
RUN yum -y install perl
RUN yum -y install dnf-plugins-core
RUN dnf -y --enablerepo=devel install ninja-build
RUN yum -y install gdb
RUN echo "source scl_source enable gcc-toolset-11" >> ~/.bashrc
RUN echo "source scl_source enable gcc-toolset-11" >> ~/.bash_profile

RUN ln -s /opt/rh/gcc-toolset-11/root/usr/bin/g++ /usr/local/bin/g++