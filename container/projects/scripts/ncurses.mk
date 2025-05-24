NCURSES_DIR = $(PROJECT_DIR)/ncurses
NCURSES_TARGET_DIR = $(ROOTFS_DIR)/usr

.PHONY: conf build install clean

conf:
	$(HIDE)bash -c 'cd $(NCURSES_DIR) && ./configure \
		--prefix=$(NCURSES_TARGET_DIR) --host=$(HOST) --with-shared \
		--without-debug --without-ada --enable-pc-files --with-cxx-binding \
		--with-cxx-shared --enable-ext-colors --enable-ext-mouse \
		--enable-overwrite --without-progs'

build:
	$(HIDE)$(MAKE) -C $(NCURSES_DIR)

install:
	$(HIDE)$(MAKE) -C $(NCURSES_DIR) install
	$(HIDE)ln -sf $(NCURSES_TARGET_DIR)/lib/libncursesw.so.6.5 $(NCURSES_TARGET_DIR)/lib/libncurses.so.6.5
	$(HIDE)ln -sf $(NCURSES_TARGET_DIR)/lib/libncursesw.so.6 $(NCURSES_TARGET_DIR)/lib/libncurses.so.6
	$(HIDE)ln -sf $(NCURSES_TARGET_DIR)/lib/libncursesw.so $(NCURSES_TARGET_DIR)/lib/libncurses.so
	$(HIDE)ln -sf $(NCURSES_TARGET_DIR)/lib/libncursesw.a $(NCURSES_TARGET_DIR)/lib/libncurses.a
	$(HIDE)ln -sf $(NCURSES_TARGET_DIR)/lib/libncurses++w.so.6.5 $(NCURSES_TARGET_DIR)/lib/libncurses++.so.6.5
	$(HIDE)ln -sf $(NCURSES_TARGET_DIR)/lib/libncurses++w.so.6 $(NCURSES_TARGET_DIR)/lib/libncurses++.so.6
	$(HIDE)ln -sf $(NCURSES_TARGET_DIR)/lib/libncurses++w.so $(NCURSES_TARGET_DIR)/lib/libncurses++.so
	$(HIDE)ln -sf $(NCURSES_TARGET_DIR)/lib/libncurses++w.a $(NCURSES_TARGET_DIR)/lib/libncurses++.a

clean:
	$(HIDE)$(MAKE) -C $(NCURSES_DIR) clean
