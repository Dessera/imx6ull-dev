BASH_PATH = $(PROJECT_BASE_PATH)/bash-5.2.37
BASH_TARGET_PATH = $(ROOTFS_PATH)/usr

NCURSES_LINK_PATH = $(ROOTFS_PATH)/usr/lib
NCURSES_INCLUDE_PATH = $(ROOTFS_PATH)/usr/include

BASH_CFLAGS = -I$(NCURSES_INCLUDE_PATH) -L$(NCURSES_LINK_PATH)
BASH_LDFLAGS = 
BASH_ENVS = CFLAGS="$(BASH_CFLAGS)" LDFLAGS="$(BASH_LDFLAGS)"

.PHONY: configure all install clean

configure:
	$(HIDE)bash -c 'cd $(BASH_PATH) && $(BASH_ENVS) ./configure				\
		--prefix=$(BASH_TARGET_PATH) --host=$(PLATFORM) --with-curses'

all:
	$(HIDE)$(MAKE) -C $(BASH_PATH)

install:
	$(HIDE)$(MAKE) -C $(BASH_PATH) install

clean:
	$(HIDE)$(MAKE) -C $(BASH_PATH) clean
