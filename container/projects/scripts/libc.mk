LIB_DIR = /usr/$(HOST)/lib
INC_DIR = /usr/$(HOST)/include
LIB_TARGET_DIR = $(ROOTFS_DIR)/usr/lib
INC_TARGET_DIR = $(ROOTFS_DIR)/usr/include

.PHONY: build install clean

build:
	@echo "libc is builtin"

install:
	$(HIDE)mkdir -p $(LIB_TARGET_DIR)
	$(HIDE)mkdir -p $(INC_TARGET_DIR)
	$(HIDE)cp -r $(LIB_DIR)/* $(LIB_TARGET_DIR)
	$(HIDE)cp -r $(INC_DIR)/* $(INC_TARGET_DIR)

clean:
	@echo "libc is builtin"