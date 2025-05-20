PROJECT_BASE_PATH := $(shell pwd)
SCRIPTS_PATH = $(PROJECT_BASE_PATH)/scripts

HIDE = @
ARCH = arm
CROSS_COMPILE = arm-linux-gnueabihf-
PLATFORM = arm-linux-gnueabihf

DIST_PATH = $(PROJECT_BASE_PATH)/dist
KERNEL_PATH = $(PROJECT_BASE_PATH)/linux-imx
KVERSION_FILE = $(KERNEL_PATH)/kversion
ROOTFS_PATH = $(DIST_PATH)/rootfs

export PROJECT_BASE_PATH SCRIPTS_PATH HIDE ARCH CROSS_COMPILE PLATFORM DIST_PATH KERNEL_PATH ROOTFS_PATH KVERSION_FILE

TARGETS = linux uboot busybox libc ncurses rtl8188eu libnl iw bash tslib

TARGETS_MK := $(addsuffix .mk, $(TARGETS))
TARGETS_INSTALL := $(addsuffix .install, $(TARGETS))
TARGETS_CLEAN := $(addsuffix .clean, $(TARGETS))
TARGETS_CONFIGURE := $(addsuffix .configure, $(TARGETS))

busybox.install: linux.install
iw.mk: libnl.install
bash.mk: ncurses.install
libc.install: busybox.install
rtl8188eu.install: busybox.install
ncurses.install: busybox.install
libnl.install: busybox.install
tslib.install: busybox.install

linux.install: linux.mk
uboot.install: uboot.mk
busybox.install: busybox.mk
libc.install: libc.mk
ncurses.install: ncurses.mk
rtl8188eu.install: rtl8188eu.mk
libnl.install: libnl.mk
iw.install: iw.mk
bash.install: bash.mk
tslib.install: tslib.mk

.PHONY: all install clean distclean reinstall $(TARGETS) $(TARGETS_MK) $(TARGETS_INSTALL) $(TARGETS_CLEAN) $(TARGETS_CONFIGURE)

mk: $(TARGETS_MK)

install: $(TARGETS_INSTALL)

clean: $(TARGETS_CLEAN)

distclean:
	rm -rf $(DIST_PATH)

reinstall: distclean install

$(TARGETS_MK):
	$(HIDE)$(MAKE) -C $(SCRIPTS_PATH) -f $@ all

$(TARGETS_INSTALL):
	$(HIDE)$(MAKE) -C $(SCRIPTS_PATH) -f $(subst .install,.mk, $@) install

$(TARGETS_CLEAN):
	$(HIDE)$(MAKE) -C $(SCRIPTS_PATH) -f $(subst .clean,.mk, $@) clean

$(TARGETS_CONFIGURE):
	$(HIDE)$(MAKE) -C $(SCRIPTS_PATH) -f $(subst .configure,.mk, $@) configure
