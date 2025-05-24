BASH_DIR = $(PROJECT_DIR)/bash
BASH_TARGET_DIR = $(ROOTFS_DIR)/usr

LINK_DIR = $(ROOTFS_DIR)/usr/lib
INCLUDE_DIR = $(ROOTFS_DIR)/usr/include

BASH_CFLAGS = -I$(INCLUDE_DIR) -L$(LINK_DIR)
BASH_ENVS = CFLAGS="$(BASH_CFLAGS)"

.PHONY: conf build install clean

conf:
	$(HIDE)bash -c 'cd $(BASH_DIR) && $(BASH_ENVS) ./configure \
		--prefix=$(BASH_TARGET_DIR) --host=$(HOST) --with-curses'

build:
	$(HIDE)$(MAKE) -C $(BASH_DIR)

install:
	$(HIDE)$(MAKE) -C $(BASH_DIR) install

clean:
	$(HIDE)$(MAKE) -C $(BASH_DIR) clean
