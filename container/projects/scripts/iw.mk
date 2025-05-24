IW_DIR = $(PROJECT_DIR)/iw
IW_TARGET_DIR = $(ROOTFS_DIR)/usr

IW_CFLAGS = -I$(ROOTFS_DIR)/usr/include -O2
IW_PKGCONFIG = PKG_CONFIG_PATH=$(ROOTFS_DIR)/usr/lib/pkgconfig pkg-config

.PHONY: build install clean

build:
	$(HIDE)$(MAKE) -C $(IW_DIR) PREFIX=$(IW_TARGET_DIR) \
		CC=$(CROSS_COMPILE)-gcc CFLAGS="$(IW_CFLAGS)" PKG_CONFIG="$(IW_PKGCONFIG)"

install:
	$(HIDE)$(MAKE) -C $(IW_DIR) PREFIX=$(IW_TARGET_DIR) \
		CC=$(CROSS_COMPILE)gcc CFLAGS="$(IW_CFLAGS)" \
		PKG_CONFIG="$(IW_PKGCONFIG)" install

clean:
	$(HIDE)$(MAKE) -C $(IW_DIR) clean
