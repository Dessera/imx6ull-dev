NL_PATH = $(PROJECT_BASE_PATH)/libnl
NL_TARGET_PATH = $(ROOTFS_PATH)

.PHONY: configure all install clean

configure:
	$(HIDE)bash -c 'cd $(NL_PATH) && ./configure --prefix=$(NL_TARGET_PATH)	\
		--host=$(PLATFORM)'

all:
	$(HIDE)$(MAKE) -C $(NL_PATH)

# libnl install the include to $(ROOTFS_PATH)/include
# but we need it in $(ROOTFS_PATH)/usr/include
install:
	$(HIDE)$(MAKE) -C $(NL_PATH) install
	$(HIDE)rm -rf $(ROOTFS_PATH)/usr/include/libnl3
	$(HIDE)mv $(ROOTFS_PATH)/include/libnl3 $(ROOTFS_PATH)/usr/include
	$(HIDE)rm -rf $(ROOTFS_PATH)/include

clean:
	$(HIDE)$(MAKE) -C $(NL_PATH) clean
