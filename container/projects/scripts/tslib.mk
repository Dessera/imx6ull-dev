TSLIB_DIR = $(PROJECT_DIR)/tslib
TSLIB_TMP_DIR = /tmp/tslib_build

.PHONY: conf build install clean

conf:
	$(HIDE)bash -c 'cd $(TSLIB_DIR) && ./configure \
		--prefix=$(TSLIB_TMP_DIR) --host=$(HOST) --enable-shared'

build:
	$(HIDE)$(MAKE) -C $(TSLIB_DIR)

install:
	$(HIDE)rm -rf $(TSLIB_TMP_DIR)
	$(HIDE)$(MAKE) -C $(TSLIB_DIR) install
	$(HIDE)mkdir -p $(ROOTFS_DIR)/etc $(ROOTFS_DIR)/usr
	$(HIDE)cp -r $(TSLIB_TMP_DIR)/etc/* $(ROOTFS_DIR)/etc
	$(HIDE)rm -rf $(TSLIB_TMP_DIR)/etc
	$(HIDE)cp -r $(TSLIB_TMP_DIR)/* $(ROOTFS_DIR)/usr

clean:
	$(HIDE)$(MAKE) -C $(TSLIB_DIR) clean
