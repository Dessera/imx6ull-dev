NL_PATH = $(PROJECT_BASE_PATH)/libnl
NL_TARGET_PATH = $(ROOTFS_PATH)
NL_TMP_TARGET_PATH = /tmp/libnl_build

.PHONY: configure all install clean

configure:
	$(HIDE)bash -c 'cd $(NL_PATH) && ./configure --prefix=$(NL_TMP_TARGET_PATH)	\
		--host=$(PLATFORM)'

all:
	$(HIDE)$(MAKE) -C $(NL_PATH)

install:
	$(HIDE)rm -rf $(NL_TMP_TARGET_PATH)
	$(HIDE)$(MAKE) -C $(NL_PATH) install
	$(HIDE)cp -r $(NL_TMP_TARGET_PATH)/etc/* $(NL_TARGET_PATH)/etc
	$(HIDE)rm -rf $(NL_TMP_TARGET_PATH)/etc
	$(HIDE)cp -r $(NL_TMP_TARGET_PATH)/* $(NL_TARGET_PATH)/usr

clean:
	$(HIDE)$(MAKE) -C $(NL_PATH) clean
