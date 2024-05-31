FROM centos:7
RUN yum -y install epel-release
RUN yum -y install ninja-build

RUN yum -y install centos-release-scl-rh
RUN yum -y install devtoolset-11
RUN yum -y install python3-devel
RUN yum -y install perl-Data-Dumper
RUN pip3 install scikit-build --upgrade
RUN pip3 install conan --upgrade
RUN pip3 install pip --upgrade
RUN pip3 install cmake --upgrade

# For Conan build all
RUN yum groupinstall -y 'Development Tools'
RUN yum install -y perl-Digest-SHA

RUN yum install -y dnf
RUN yum install -y rh-python38