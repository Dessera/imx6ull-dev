PROJECT_DIR := $(shell pwd)
SCRIPTS_DIR = $(PROJECT_DIR)/scripts

HIDE = @
ARCH = arm
HOST = arm-linux-gnueabihf
CROSS_COMPILE = $(HOST)-

DIST_DIR = $(PROJECT_DIR)/dist
ROOTFS_DIR = $(DIST_DIR)/rootfs

KERNEL_DIR = $(PROJECT_DIR)/linux-imx
KVERSION_PATH = $(KERNEL_DIR)/kversion

export PROJECT_DIR SCRIPTS_DIR HIDE ARCH CROSS_COMPILE HOST DIST_DIR KERNEL_DIR ROOTFS_DIR KVERSION_PATH

TARGETS = linux uboot busybox libc ncurses rtl8188eu libnl iw bash tslib alsa_lib alsa_utils zlib libffi cpython

TARGETS_BUILD := $(addsuffix .build, $(TARGETS))
TARGETS_INSTALL := $(addsuffix .install, $(TARGETS))
TARGETS_CLEAN := $(addsuffix .clean, $(TARGETS))
TARGETS_CONF := $(addsuffix .conf, $(TARGETS))
TARGETS_OBUILD := $(addsuffix .obuild, $(TARGETS))
TARGETS_OINSTALL := $(addsuffix .oinstall, $(TARGETS))

rtl8188eu.install: linux.build
busybox.install: linux.build

iw.build: libnl.install
bash.build: ncurses.install
alsa_utils.build: alsa_lib.install ncurses.install libc.install
cpython.build: libc.install zlib.install libffi.install

linux.install: linux.build
uboot.install: uboot.build
busybox.install: busybox.build
libc.install: libc.build
ncurses.install: ncurses.build
rtl8188eu.install: rtl8188eu.build
libnl.install: libnl.build
iw.install: iw.build
bash.install: bash.build
tslib.install: tslib.build
alsa_lib.install: alsa_lib.build
alsa_utils.install: alsa_utils.build
zlib.install: zlib.build
libffi.install: libffi.build
cpython.install: cpython.build

.PHONY: all install clean distclean reinstall $(TARGETS) $(TARGETS_BUILD) $(TARGETS_OBUILD) $(TARGETS_OINSTALL) $(TARGETS_INSTALL) $(TARGETS_CLEAN) $(TARGETS_CONF)

build: $(TARGETS_BUILD)

install: $(TARGETS_INSTALL)

clean: $(TARGETS_CLEAN)

distclean:
	$(HIDE)rm -rf $(DIST_DIR)

reinstall:
	$(HIDE)$(MAKE) distclean
	$(HIDE)$(MAKE) install

$(TARGETS_BUILD):
	$(HIDE)echo Running Phase $@
	$(HIDE)$(MAKE) -C $(SCRIPTS_DIR) -f $(subst .build,.mk, $@) build

$(TARGETS_INSTALL):
	$(HIDE)echo Running Phase $@
	$(HIDE)$(MAKE) -C $(SCRIPTS_DIR) -f $(subst .install,.mk, $@) install

$(TARGETS_CLEAN):
	$(HIDE)echo Running Phase $@
	$(HIDE)$(MAKE) -C $(SCRIPTS_DIR) -f $(subst .clean,.mk, $@) clean

$(TARGETS_CONF):
	$(HIDE)echo Running Phase $@
	$(HIDE)$(MAKE) -C $(SCRIPTS_DIR) -f $(subst .conf,.mk, $@) conf

$(TARGETS_OBUILD):
	$(HIDE)echo Running Phase $@
	$(HIDE)$(MAKE) -C $(SCRIPTS_DIR) -f $(subst .obuild,.mk, $@) build

$(TARGETS_OINSTALL):
	$(HIDE)echo Running Phase $@
	$(HIDE)$(MAKE) -C $(SCRIPTS_DIR) -f $(subst .oinstall,.mk, $@) install