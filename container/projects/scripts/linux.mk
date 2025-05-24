LINUX_DTB_PATH = $(KERNEL_DIR)/arch/$(ARCH)/boot/dts/nxp/imx/imx6ull-opendos-emmc.dtb
LINUX_IMG_PATH = $(KERNEL_DIR)/arch/$(ARCH)/boot/zImage

LINUX_DTB_TARGET = $(DIST_DIR)/boot/imx6ull-14x14-evk.dtb
LINUX_IMG_TARGET = $(DIST_DIR)/boot/zImage

.PHONY: conf build install clean

conf:
	$(HIDE)$(MAKE) -C $(KERNEL_DIR) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) \
		menuconfig

build:
	$(HIDE)$(MAKE) -C $(KERNEL_DIR) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE)
	$(HIDE)strings $(KERNEL_DIR)/vmlinux | grep -m1 "Linux version" | awk '{print $$3}' > $(KVERSION_PATH)

install:
	$(HIDE)mkdir -p $(DIST_DIR)/boot
	$(HIDE)cp $(LINUX_DTB_PATH) $(LINUX_DTB_TARGET)
	$(HIDE)cp $(LINUX_IMG_PATH) $(LINUX_IMG_TARGET)

clean:
	$(HIDE)$(MAKE) -C $(KERNEL_DIR) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) clean
