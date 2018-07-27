cc=cc
cflags=-O2 -Wall -Wextra
install_dir=$(HOME)/bin

all: kb_mode hid_listen

kb_mode: kb_mode.c
	$(cc) $(cflags) $< -o $@

hid_listen:
	$(MAKE) -C hid_listen.submodule
	cp hid_listen.submodule/hid_listen hid_listen

.PHONY: clean install uninstall

clean:
	rm -fv {kb_mode,hid_listen}
	$(MAKE) -C hid_listen.submodule clean

install: kb_mode hid_listen
	install -sv {kb_mode,hid_listen} $(install_dir)
	install -v kb_listen.sh $(install_dir)

uninstall:
	rm -v $(install_dir)/{kb_mode,hid_listen,kb_listen.sh}
