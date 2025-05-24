ALSA_UTILS_DIR = $(PROJECT_DIR)/alsa-utils
ALSA_UTILS_TARGET_DIR = $(ROOTFS_DIR)/usr

ALSA_UTILS_ENVS = CFLAGS="-I$(ROOTFS_DIR)/usr/include -L$(ROOTFS_DIR)/usr/lib"

.PHONY: conf build install clean

conf:
	$(HIDE)bash -c 'cd $(ALSA_UTILS_DIR) && $(ALSA_UTILS_ENVS) ./configure \
		--host=$(HOST) --prefix=$(ALSA_UTILS_TARGET_DIR)'

build:
	$(HIDE)$(MAKE) -C $(ALSA_UTILS_DIR)

install:
	$(HIDE)$(MAKE) -C $(ALSA_UTILS_DIR) install

clean:
	$(HIDE)$(MAKE) -C $(ALSA_UTILS_DIR) clean
