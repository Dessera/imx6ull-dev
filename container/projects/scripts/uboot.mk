UBOOT_DIR = $(PROJECT_DIR)/uboot-imx
UBOOT_BIN_PATH = $(UBOOT_DIR)/u-boot-dtb.imx
LOGO_BMP_PATH = $(UBOOT_DIR)/tools/logos/deslab-mini.bmp
UBOOT_TARGET_PATH = $(DIST_DIR)/u-boot-dtb.imx


.PHONY: conf build install clean

conf:
	$(HIDE)$(MAKE) -C $(UBOOT_DIR) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) \
		menuconfig

build:
	$(HIDE)$(MAKE) -C $(UBOOT_DIR) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) \
		LOGO_BMP=$(LOGO_BMP_PATH)

install:
	$(HIDE)mkdir -p $(DIST_DIR)
	$(HIDE)cp $(UBOOT_BIN_PATH) $(UBOOT_TARGET_PATH)

clean:
	$(HIDE)$(MAKE) -C $(UBOOT_DIR) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) \
		clean