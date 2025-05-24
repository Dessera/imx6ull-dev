LIBFFI_DIR = $(PROJECT_DIR)/libffi
LIBFFI_TARGET_DIR = $(ROOTFS_DIR)/usr

.PHONY: conf build install clean

conf:
	$(HIDE)bash -c 'cd $(LIBFFI_DIR) && ./configure \
		--prefix=$(LIBFFI_TARGET_DIR) --host=$(HOST)'

build:
	$(HIDE)$(MAKE) -C $(LIBFFI_DIR)

install:
	$(HIDE)$(MAKE) -C $(LIBFFI_DIR) install

clean:
	$(HIDE)$(MAKE) -C $(LIBFFI_DIR) clean
