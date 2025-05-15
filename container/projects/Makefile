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

SCRIPTS = linux.mk			\
					uboot.mk			\
					rootfs.mk			\
					libc.mk				\
					ncurses.mk		\
					bash.mk				\
					rtl8188eu.mk	\
					nl.mk					\
					iw.mk	

SCRIPTS_CLEANER := $(SCRIPTS:.mk=.clean)
SCRIPTS_INSTALLER := $(SCRIPTS:.mk=.install)
SCRIPTS_CONFIGURE := $(SCRIPTS:.mk=.configure)

rootfs.install: linux.install

libc.install: rootfs.install

ncurses.install: rootfs.install

nl.install: rootfs.install

iw.mk: nl.install

bash.mk: ncurses.install

.PHONY: all install clean distclean reinstall $(SCRIPTS) $(SCRIPTS_CLEANER) $(SCRIPTS_INSTALLER)

all: $(SCRIPTS)

install: $(SCRIPTS_INSTALLER)

clean: $(SCRIPTS_CLEANER)

distclean:
	rm -rf $(DIST_PATH)

reinstall: distclean install

$(SCRIPTS):
	$(HIDE)$(MAKE) -C $(SCRIPTS_PATH) -f $@ all

$(SCRIPTS_INSTALLER): $(SCRIPTS)
	$(HIDE)$(MAKE) -C $(SCRIPTS_PATH) -f $(subst .install,.mk, $@) install

$(SCRIPTS_CLEANER):
	$(HIDE)$(MAKE) -C $(SCRIPTS_PATH) -f $(subst .clean,.mk, $@) clean

$(SCRIPTS_CONFIGURE):
	$(HIDE)$(MAKE) -C $(SCRIPTS_PATH) -f $(subst .configure,.mk, $@) configure
