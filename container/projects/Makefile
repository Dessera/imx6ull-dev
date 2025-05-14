PROJECT_BASE_PATH := $(shell pwd)
SCRIPTS_PATH = $(PROJECT_BASE_PATH)/scripts

HIDE = @
ARCH = arm
CROSS_COMPILE = arm-linux-gnueabihf-
PLATFORM = arm-linux-gnueabihf

KVERSION_FILE = $(DIST_PATH)/kversion
DIST_PATH = $(PROJECT_BASE_PATH)/dist
ROOTFS_PATH = $(DIST_PATH)/rootfs

export PROJECT_BASE_PATH SCRIPTS_PATH HIDE ARCH CROSS_COMPILE PLATFORM DIST_PATH ROOTFS_PATH KVERSION_FILE

SCRIPTS = linux.mk		\
					uboot.mk		\
					rootfs.mk		\
					libc.mk			\
					ncurses.mk	\
					bash.mk

SCRIPTS_CLEANER := $(SCRIPTS:.mk=.clean)
SCRIPTS_INSTALLER := $(SCRIPTS:.mk=.install)

rootfs.install: linux.install

libc.install: rootfs.install

ncurses.install: rootfs.install

bash.mk: ncurses.install

.PHONY: all install clean

all: $(SCRIPTS)

install: $(SCRIPTS_INSTALLER)

clean: $(SCRIPTS_CLEANER)

distclean:
	rm -rf $(DIST_PATH)

%.configure:
	$(HIDE)$(MAKE) -C $(SCRIPTS_PATH) -f $(subst .configure,.mk, $@) configure

%.mk:
	$(HIDE)$(MAKE) -C $(SCRIPTS_PATH) -f $@ all

%.install: %.mk
	$(HIDE)$(MAKE) -C $(SCRIPTS_PATH) -f $(subst .install,.mk, $@) install

%.clean:
	$(HIDE)$(MAKE) -C $(SCRIPTS_PATH) -f $(subst .clean,.mk, $@) clean
