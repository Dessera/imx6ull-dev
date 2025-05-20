TSLIB_PATH = $(PROJECT_BASE_PATH)/tslib
TSLIB_TARGET_PATH = $(ROOTFS_PATH)
TSLIB_TMP_TARGET_PATH = /tmp/tslib_build

.PHONY: configure all install clean

configure:
	$(HIDE)bash -c 'cd $(TSLIB_PATH) && ./configure --prefix=$(TSLIB_TMP_TARGET_PATH)	\
		--host=$(PLATFORM) --enable-shared --enable-static'

all:
	$(HIDE)$(MAKE) -C $(TSLIB_PATH)

install:
	$(HIDE)rm -rf $(TSLIB_TMP_TARGET_PATH)
	$(HIDE)$(MAKE) -C $(TSLIB_PATH) install
	$(HIDE)cp -r $(TSLIB_TMP_TARGET_PATH)/etc/* $(TSLIB_TARGET_PATH)/etc
	$(HIDE)rm -rf $(TSLIB_TMP_TARGET_PATH)/etc
	$(HIDE)cp -r $(TSLIB_TMP_TARGET_PATH)/* $(TSLIB_TARGET_PATH)/usr

clean:
	$(HIDE)$(MAKE) -C $(TSLIB_PATH) clean
