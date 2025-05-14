NCURSES_PATH = $(PROJECT_BASE_PATH)/ncurses-6.5
NCURSES_TARGET_PATH = $(ROOTFS_PATH)/usr

.PHONY: configure all install clean

configure:
	$(HIDE)bash -c 'cd $(NCURSES_PATH) && ./configure								\
		--prefix=$(NCURSES_TARGET_PATH) --host=$(PLATFORM)						\
		--with-shared --without-debug --without-ada --enable-pc-files	\
		--with-cxx-binding --with-cxx-shared --enable-ext-colors			\
		--enable-ext-mouse --enable-overwrite --without-progs'

all:
	$(HIDE)$(MAKE) -C $(NCURSES_PATH)

install:
	$(HIDE)$(MAKE) -C $(NCURSES_PATH) install
	$(HIDE)ln -sf $(NCURSES_TARGET_PATH)/lib/libncursesw.so.6.5 $(NCURSES_TARGET_PATH)/lib/libncurses.so.6.5
	$(HIDE)ln -sf $(NCURSES_TARGET_PATH)/lib/libncursesw.so.6 $(NCURSES_TARGET_PATH)/lib/libncurses.so.6
	$(HIDE)ln -sf $(NCURSES_TARGET_PATH)/lib/libncursesw.so $(NCURSES_TARGET_PATH)/lib/libncurses.so
	$(HIDE)ln -sf $(NCURSES_TARGET_PATH)/lib/libncursesw.a $(NCURSES_TARGET_PATH)/lib/libncurses.a
	$(HIDE)ln -sf $(NCURSES_TARGET_PATH)/lib/libncurses++w.so.6.5 $(NCURSES_TARGET_PATH)/lib/libncurses++.so.6.5
	$(HIDE)ln -sf $(NCURSES_TARGET_PATH)/lib/libncurses++w.so.6 $(NCURSES_TARGET_PATH)/lib/libncurses++.so.6
	$(HIDE)ln -sf $(NCURSES_TARGET_PATH)/lib/libncurses++w.so $(NCURSES_TARGET_PATH)/lib/libncurses++.so
	$(HIDE)ln -sf $(NCURSES_TARGET_PATH)/lib/libncurses++w.a $(NCURSES_TARGET_PATH)/lib/libncurses++.a

clean:
	$(HIDE)$(MAKE) -C $(NCURSES_PATH) clean
