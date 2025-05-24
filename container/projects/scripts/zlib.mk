ZLIB_DIR = $(PROJECT_DIR)/zlib
ZLIB_TARGET_DIR = $(ROOTFS_DIR)/usr

.PHONY: conf build install clean

conf:
	$(HIDE)bash -c 'cd $(ZLIB_DIR) && cmake -S . -B build \
		-D CMAKE_BUILD_TYPE=Release	-D CMAKE_C_COMPILER=$(CROSS_COMPILE)gcc \
		-DINSTALL_BIN_DIR=$(ZLIB_TARGET_DIR)/bin \
		-DINSTALL_LIB_DIR=$(ZLIB_TARGET_DIR)/lib \
		-DINSTALL_MAN_DIR=$(ZLIB_TARGET_DIR)/share/man/ \
		-DINSTALL_PKGCONFIG_DIR=$(ZLIB_TARGET_DIR)/lib/pkgconfig \
		-DINSTALL_INC_DIR=$(ZLIB_TARGET_DIR)/include'

build:
	$(HIDE)bash -c 'cd $(ZLIB_DIR) && cmake --build build'

install:
	$(HIDE)bash -c 'cd $(ZLIB_DIR) && cmake --install build'

clean:
	$(HIDE)bash -c 'cd $(ZLIB_DIR)/build && make clean'
