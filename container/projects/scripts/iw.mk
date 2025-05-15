IW_PATH = $(PROJECT_BASE_PATH)/iw-6.9
IW_TARGET_PATH = $(ROOTFS_PATH)/usr

.PHONY: all install clean

all:
	$(HIDE)$(MAKE) -C $(IW_PATH) PREFIX=$(IW_TARGET_PATH)											\
		CC=$(CROSS_COMPILE)-gcc CFLAGS="-I$(ROOTFS_PATH)/usr/include -O2"				\
		PKG_CONFIG="PKG_CONFIG_PATH=$(ROOTFS_PATH)/usr/lib/pkgconfig pkg-config"

install:
	$(HIDE)$(MAKE) -C $(IW_PATH) PREFIX=$(IW_TARGET_PATH)											\
		CC=$(CROSS_COMPILE)-gcc CFLAGS="-I$(ROOTFS_PATH)/usr/include -O2"				\
		PKG_CONFIG="PKG_CONFIG_PATH=$(ROOTFS_PATH)/usr/lib/pkgconfig pkg-config" install

clean:
	$(HIDE)$(MAKE) -C $(IW_PATH) clean
