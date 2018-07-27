cc=cc
cflags=-O2 -Wall -Wextra

all: kb_mode hid_listen

kb_mode: kb_mode.c
	$(cc) $(cflags) $< -o $@

hid_listen:
	$(MAKE) -C hid_listen.submodule
	cp hid_listen.submodule/hid_listen hid_listen

.PHONY: clean

clean:
	rm -fv kb_mode
	rm -fv hid_listen
	$(MAKE) -C hid_listen.submodule clean
