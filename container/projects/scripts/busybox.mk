BUSYBOX_DIR = $(PROJECT_DIR)/busybox
BUSYBOX_ETC_DIR = $(PROJECT_DIR)/rootfs-etc

BUSYBOX_DIRS = dev proc sys tmp mnt etc root usr/lib var/lib var/lock
BUSYBOX_ABS_DIRS = $(addprefix $(ROOTFS_DIR)/,$(BUSYBOX_DIRS))

.PHONY: conf build install clean

conf:
	$(HIDE)$(MAKE) -C $(BUSYBOX_DIR) ARCH=$(ARCH) \
		CROSS_COMPILE=$(CROSS_COMPILE) menuconfig

build:
	$(HIDE)$(MAKE) -C $(BUSYBOX_DIR) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE)

install:
	$(HIDE)mkdir -p $(ROOTFS_DIR)
	$(HIDE)$(MAKE) -C $(BUSYBOX_DIR) ARCH=$(ARCH) \
		CROSS_COMPILE=$(CROSS_COMPILE) CONFIG_PREFIX=$(ROOTFS_DIR) install
	$(HIDE)mkdir -p $(BUSYBOX_ABS_DIRS)
	$(HIDE)ln -sf usr/lib $(ROOTFS_DIR)/lib
	$(HIDE)mkdir -p $(ROOTFS_DIR)/lib/modules/$(shell cat $(KVERSION_PATH))
	$(HIDE)cp -r $(BUSYBOX_ETC_DIR)/* $(ROOTFS_DIR)/etc

clean:
	$(HIDE)$(MAKE) -C $(BUSYBOX_DIR) clean
