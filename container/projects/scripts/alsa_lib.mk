ALSA_LIB_DIR = $(PROJECT_DIR)/alsa-lib
ALSA_LIB_TARGET_DIR = $(ROOTFS_DIR)/usr

.PHONY: conf build install clean

conf:
	$(HIDE)bash -c 'cd $(ALSA_LIB_DIR) && ./configure \
		--prefix=$(ALSA_LIB_TARGET_DIR) --host=$(HOST) \
		--with-configdir=/usr/share/alsa'

build:
	$(HIDE)$(MAKE) -C $(ALSA_LIB_DIR)

install:
	$(HIDE)$(MAKE) -C $(ALSA_LIB_DIR) install

clean:
	$(HIDE)$(MAKE) -C $(ALSA_LIB_DIR) clean
