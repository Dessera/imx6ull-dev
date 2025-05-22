ALSA_LIB_PATH = $(PROJECT_BASE_PATH)/alsa-lib
ALSA_LIB_TARGET_PATH = $(ROOTFS_PATH)/usr

.PHONY: configure all install clean

configure:
	$(HIDE)bash -c 'cd $(ALSA_LIB_PATH) && ./configure --prefix=$(ALSA_LIB_TARGET_PATH)	\
		--host=$(PLATFORM) --with-configdir=/usr/share/alsa'

all:
	$(HIDE)$(MAKE) -C $(ALSA_LIB_PATH)

install:
	$(HIDE)$(MAKE) -C $(ALSA_LIB_PATH) install

clean:
	$(HIDE)$(MAKE) -C $(ALSA_LIB_PATH) clean
