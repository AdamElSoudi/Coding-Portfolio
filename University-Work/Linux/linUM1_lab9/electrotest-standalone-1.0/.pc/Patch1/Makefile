CC = gcc
CFLAGS = -Wall -Wextra -std=c99
BIN = electrotest-standalone

all: $(BIN)
$(BIN): electrotest-standalone.c
	$(CC) $(CFLAGS) electrotest-standalone.c -o $(BIN)

install:
	install -d $(DESTDIR)
	install -m 755 $(BIN) $(DESTDIR)/

clean:
	rm -f $(DESTDIR)/$(BIN)
