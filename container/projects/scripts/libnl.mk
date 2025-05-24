LIBNL_DIR = $(PROJECT_DIR)/libnl
LIBNL_TMP_DIR = /tmp/libnl_build

.PHONY: conf build install clean

conf:
	$(HIDE)bash -c 'cd $(LIBNL_DIR) && ./configure --prefix=$(LIBNL_TMP_DIR) \
		--host=$(HOST)'

build:
	$(HIDE)$(MAKE) -C $(LIBNL_DIR)

install:
	$(HIDE)rm -rf $(LIBNL_TMP_DIR)
	$(HIDE)$(MAKE) -C $(LIBNL_DIR) install
	$(HIDE)mkdir -p $(ROOTFS_DIR)/etc $(ROOTFS_DIR)/usr
	$(HIDE)cp -r $(LIBNL_TMP_DIR)/etc/* $(ROOTFS_DIR)/etc
	$(HIDE)rm -rf $(LIBNL_TMP_DIR)/etc
	$(HIDE)cp -r $(LIBNL_TMP_DIR)/* $(ROOTFS_DIR)/usr

clean:
	$(HIDE)$(MAKE) -C $(LIBNL_DIR) clean
