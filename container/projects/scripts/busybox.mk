BUSYBOX_PATH = $(PROJECT_BASE_PATH)/busybox-1.36.1
BUSYBOX_ETC_PATH = $(PROJECT_BASE_PATH)/rootfs-etc

.PHONY: all install clean

all:
	$(HIDE)$(MAKE) -C $(BUSYBOX_PATH) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE)

install:
	$(HIDE)mkdir -p $(ROOTFS_PATH)
	$(HIDE)$(MAKE) -C $(BUSYBOX_PATH) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) CONFIG_PREFIX=$(ROOTFS_PATH) install
	$(HIDE)mkdir -p $(ROOTFS_PATH)/dev $(ROOTFS_PATH)/proc $(ROOTFS_PATH)/sys \
		$(ROOTFS_PATH)/tmp $(ROOTFS_PATH)/mnt $(ROOTFS_PATH)/etc $(ROOTFS_PATH)/root
	$(HIDE)mkdir -p $(ROOTFS_PATH)/usr/lib
	$(HIDE)mkdir -p $(ROOTFS_PATH)/var/lib $(ROOTFS_PATH)/var/lock
	$(HIDE)ln -sf usr/lib $(ROOTFS_PATH)/lib
	$(HIDE)mkdir -p $(ROOTFS_PATH)/lib/modules/$(shell cat $(KVERSION_FILE))
	$(HIDE)cp -r $(BUSYBOX_ETC_PATH)/* $(ROOTFS_PATH)/etc

clean:
	$(HIDE)$(MAKE) -C $(BUSYBOX_PATH) clean
