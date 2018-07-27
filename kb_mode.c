#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define BUFFER_SIZE 32

#define unreachable()  __builtin_unreachable()

typedef enum {
  Base_mode = 0,
  Sym_mode,
  Num_mode,
  Navi_mode,
  Mouse_mode,
  Albhed_mode,
  No_mode,
} Mode_e;

static const char *
mode_to_string(Mode_e mode) {
  switch (mode) {
  case Base_mode:
    return "base";
  case Sym_mode:
    return "symbols";
  case Num_mode:
    return "numpad";
  case Navi_mode:
    return "navi";
  case Mouse_mode:
    return "mouser";
  case Albhed_mode:
    return "albhed";
  case No_mode:
    return "none";
  }
  unreachable();
}

static void
read_line(char *buffer, size_t size) {
  char c;
  size_t i = 0;

  while (i < size) {
    c = getchar();

    if (c == EOF) {
      fprintf(stderr, "Unexpected EOF\n");
      exit(EXIT_FAILURE);
    }

    if (c == '\n') {
      buffer[i] = '\0';
      return;
    }

    buffer[i++] = c;
  }
  buffer[BUFFER_SIZE-1] = '\0';
}

static Mode_e
process_stdin(void) {
  char buffer[BUFFER_SIZE];

  read_line(buffer, BUFFER_SIZE);

  if (strcmp(buffer, "Layer: base") == 0)
    return Base_mode;
  else if (strcmp(buffer, "Layer: numpad") == 0)
    return Num_mode;
  else if (strcmp(buffer, "Layer: symbols") == 0)
    return Sym_mode;
  else if (strcmp(buffer, "Layer: navi") == 0)
    return Navi_mode;
  else if (strcmp(buffer, "Layer: mouser") == 0)
    return Mouse_mode;
  else if (strcmp(buffer, "Layer: albhed") == 0)
    return Albhed_mode;

  return No_mode;
}

int main(int argc, char *argv[]) {
  Mode_e mode;

  if (argc < 2) {
    fprintf(stderr, "Usage: %s filename\n", argv[0]);
    exit(EXIT_FAILURE);
  }

  for (;;) {
    mode = process_stdin();
    if (mode != No_mode) {
      FILE *f = fopen(argv[1], "w");
      fprintf(f, "%s\n", mode_to_string(mode));
      fclose(f);
    }
  }
  unreachable();
}
