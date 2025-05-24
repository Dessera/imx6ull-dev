CPYTHON_DIR = $(PROJECT_DIR)/cpython
CPYTHON_TARGET_DIR = $(ROOTFS_DIR)/usr

LINK_DIR = $(ROOTFS_DIR)/usr/lib
INCLUDE_DIR = $(ROOTFS_DIR)/usr/include

CPYTHON_CFLAGS = -I$(INCLUDE_DIR) -L$(LINK_DIR)
CPYTHON_LDFLAGS = -L$(LINK_DIR)
CPYTHON_ENVS = CFLAGS="$(CPYTHON_CFLAGS)" LDFLAGS="$(CPYTHON_LDFLAGS)"

.PHONY: conf build install clean

conf:
	$(HIDE)bash -c 'cd $(CPYTHON_DIR) && $(CPYTHON_ENVS) ./configure \
		--host=$(HOST) --build=x86_64-linux-gnu \
		--prefix=$(CPYTHON_TARGET_DIR) --with-build-python --enable-shared \
		--enable-ipv6 ac_cv_file__dev_ptmx=0 ac_cv_file__dev_ptc=0 \
		--enable-optimizations --disable-test-modules --with-ensurepip=no'

build:
	$(HIDE)$(MAKE) -C $(CPYTHON_DIR)

install:
	$(HIDE)$(MAKE) -C $(CPYTHON_DIR) install

clean:
	$(HIDE)$(MAKE) -C $(CPYTHON_DIR) clean