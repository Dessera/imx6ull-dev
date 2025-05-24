RTL_DIR = $(PROJECT_DIR)/rtl8188eus
RTL_KO_PATH = $(RTL_DIR)/8188eu.ko

.PHONY: build install clean

build:
	$(HIDE)$(MAKE) -C $(RTL_DIR) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) \
		KSRC=$(KERNEL_DIR)

install:
	$(HIDE)mkdir -p $(ROOTFS_DIR)/usr/lib/modules/$(shell cat $(KVERSION_PATH))
	$(HIDE)cp $(RTL_KO_PATH) $(ROOTFS_DIR)/usr/lib/modules/$(shell cat $(KVERSION_PATH))

clean:
	$(HIDE)$(MAKE) -C $(RTL_DIR) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) \
		KSRC=$(KERNEL_DIR) clean
