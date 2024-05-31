.PHONY: release debug test clean setup benchmark

# Detect the operating system
UNAME_S := $(shell uname -s)

# Common variables
BUILD_DIR_PREFIX = build

IS_CENTOS := $(shell grep -q "centos" /etc/os-release && echo "yes" || echo "no")

# Conditional source command based on OS
ifeq ($(IS_CENTOS),yes)
    ENABLE_ENV = source scl_source enable devtoolset-11 && source scl_source enable rh-python38

else
    ENABLE_ENV = @echo "Not sourcing devtoolset-11 on non-Linux OS"
endif


setup:
	$(ENABLE_ENV) && \
	conan profile detect --force && \
	conan install . --output-folder=build --build=b2 --build=missing && \
	cmake -G Ninja --preset conan-release -DCMAKE_CXX_COMPILER=/opt/rh/devtoolset-11/root/usr/bin/g++

# Function to setup and build a directory
define build_target
	$(ENABLE_GCC) && \
	lowercase=`echo $(1) | tr A-Z a-z`; \
	mkdir -p $(BUILD_DIR_PREFIX)-$$lowercase && \
	cd build && \
	cmake .. -DCMAKE_BUILD_TYPE=Release -DBUILD_TYPE=$(1) $(2) && \
	ninja
endef

release:
	$(call build_target,Release)

debug:
	$(call build_target,Debug)

test:
	$(call build_target,Test)
	cd build/tests && \
	ctest -R cex_conn_test -V --rerun-failed

benchmark:
	$(call build_target,Debug)
	cd build/benchmark && \
	./benchmark

clean:
	rm -rf $(BUILD_DIR_PREFIX)-release $(BUILD_DIR_PREFIX)-debug $(BUILD_DIR_PREFIX)-test \
	rm -rf generated