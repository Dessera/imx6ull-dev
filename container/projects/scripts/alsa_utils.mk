ALSA_UTILS_PATH = $(PROJECT_BASE_PATH)/alsa-utils
ALSA_UTILS_TARGET_PATH = $(ROOTFS_PATH)/usr

ALSA_UTILS_ENVS = CFLAGS="-I$(ROOTFS_PATH)/usr/include -L$(ROOTFS_PATH)/lib"

.PHONY: configure all install clean

configure:
	$(HIDE)bash -c 'cd $(ALSA_UTILS_PATH) && $(ALSA_UTILS_ENVS) ./configure	\
		--host=$(PLATFORM) --prefix=$(ALSA_UTILS_TARGET_PATH)'

all:
	$(HIDE)$(MAKE) -C $(ALSA_UTILS_PATH)

install:
	$(HIDE)$(MAKE) -C $(ALSA_UTILS_PATH) install

clean:
	$(HIDE)$(MAKE) -C $(ALSA_UTILS_PATH) clean
