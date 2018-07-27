cc=cc
cflags=-O2 -Wall -Wextra

all: kb_mode

kb_mode: kb_mode.c
	$(cc) $(cflags) $< -o $@

.PHONY: clean

clean:
	rm -fv kb_mode
