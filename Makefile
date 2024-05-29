.PHONY: release debug test clean setup benchmark

# Detect the operating system
UNAME_S := $(shell uname -s)

# Common variables
BUILD_DIR_PREFIX = build

IS_CENTOS := $(shell grep -q "centos" /etc/os-release && echo "yes" || echo "no")

# Conditional source command based on OS
ifeq ($(IS_CENTOS),yes)
    ENABLE_GCC = source /opt/rh/devtoolset-11/enable
else
    ENABLE_GCC = @echo "Not sourcing devtoolset-11 on non-Linux OS"
endif


setup:
	$(ENABLE_GCC) && \
	conan profile detect --force && \
	conan install . --output-folder=build --build=missing && \
	cmake -G Ninja --preset conan-release

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