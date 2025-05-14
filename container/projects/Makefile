PROJECT_BASE_PATH := $(shell pwd)
SCRIPTS_DIR = $(PROJECT_BASE_PATH)/scripts

HIDE = @
ARCH = arm
CROSS_COMPILE = arm-linux-gnueabihf-

KVERSION_FILE = $(DIST_DIR)/kversion
DIST_DIR = $(PROJECT_BASE_PATH)/dist
ROOTFS_DIR = $(DIST_DIR)/rootfs

export PROJECT_BASE_PATH SCRIPTS_DIR HIDE ARCH CROSS_COMPILE DIST_DIR ROOTFS_DIR KVERSION_FILE

SCRIPTS = linux.script \
					uboot.script \
					rootfs.script

SCRIPTS_CLEANER := $(SCRIPTS:.script=.clean)
SCRIPTS_INSTALLER := $(SCRIPTS:.script=.install)

rootfs.install: linux.install

.PHONY: all install clean

all: $(SCRIPTS)

install: $(SCRIPTS_INSTALLER)

clean: $(SCRIPTS_CLEANER)

cleandist:
	rm -rf $(DIST_DIR)

%.script:
	$(HIDE)$(MAKE) -C $(SCRIPTS_DIR) -f $@ all

%.install: %.script
	$(HIDE)$(MAKE) -C $(SCRIPTS_DIR) -f $(subst .install,.script, $@) install

%.clean:
	$(HIDE)$(MAKE) -C $(SCRIPTS_DIR) -f $(subst .clean,.script, $@) clean
