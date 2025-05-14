LINUX_KERNEL_PATH = $(PROJECT_BASE_PATH)/linux-imx
LINUX_DTB_TARGET = imx6ull-14x14-evk-emmc.dtb
LINUX_IMG_TARGET = zImage

LINUX_DTB_PATH = $(LINUX_KERNEL_PATH)/arch/$(ARCH)/boot/dts/nxp/imx/imx6ull-opendos-emmc.dtb
LINUX_IMG_PATH = $(LINUX_KERNEL_PATH)/arch/$(ARCH)/boot/zImage

LINUX_INSTALL_PATH = $(DIST_PATH)/boot

.PHONY: all install clean

all:
	$(HIDE)$(MAKE) -C $(LINUX_KERNEL_PATH) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE)

install: all
	$(HIDE)mkdir -p $(LINUX_INSTALL_PATH)
	$(HIDE)cp $(LINUX_DTB_PATH) $(LINUX_INSTALL_PATH)/$(LINUX_DTB_TARGET)
	$(HIDE)cp $(LINUX_IMG_PATH) $(LINUX_INSTALL_PATH)/$(LINUX_IMG_TARGET)
	$(HIDE)strings $(LINUX_KERNEL_PATH)/vmlinux | grep -m1 "Linux version" | awk '{print $$3}' > $(KVERSION_FILE)

clean:
	$(HIDE)$(MAKE) -C $(LINUX_KERNEL_PATH) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) clean
