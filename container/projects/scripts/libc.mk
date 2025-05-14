LIB_PATH = /usr/$(PLATFORM)/lib
INC_PATH = /usr/$(PLATFORM)/include
LIB_TARGET_PATH = $(ROOTFS_PATH)/usr/lib
INC_TARGET_PATH = $(ROOTFS_PATH)/usr/include

.PHONY: all install clean

all:
	@echo "libc is builtin"

install:
	$(HIDE)cp -r $(LIB_PATH)/* $(LIB_TARGET_PATH)
	$(HIDE)cp -r $(INC_PATH)/* $(INC_TARGET_PATH)

clean:
	@echo "libc is builtin"