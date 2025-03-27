CC = gcc
CFLAGS = -Wall -Wextra -std=c99
BIN = electrotest-standalone

all: $(BIN)
$(BIN): electrotest-standalone.c
	$(CC) $(CFLAGS) electrotest-standalone.c -o $(BIN)

install:
	install -d $(DESTDIR)/usr/bin
	install -m 755 $(BIN) $(DESTDIR)/usr/bin/

clean:
	rm -f $(BIN)

