INSTALL_PREFIX=/usr/local

CFLAGS=`pkg-config fuse --cflags` -DDEBUG
LDFLAGS=`pkg-config fuse --libs`

sharebox: sharebox.o git-annex.o
	gcc -g -Wall $(LDFLAGS) -o sharebox sharebox.o git-annex.o

sharebox.o: sharebox.c
	gcc -g -Wall $(CFLAGS) -c sharebox.c

git-annex.o: git-annex.c git-annex.h
	gcc -g -Wall $(CFLAGS) -c git-annex.c

test: sharebox
	$(MAKE) -C tests/

clean:
	rm -f sharebox *.o
	$(MAKE) -C tests/ clean

install: sharebox
	install -Dm755 ./sharebox $(INSTALL_PREFIX)/bin/sharebox
	install -Dm755 ./mkfs.sharebox $(INSTALL_PREFIX)/sbin/mkfs.sharebox

uninstall:
	rm -f $(INSTALL_PREFIX)/bin/sharebox
	rm -f $(INSTALL_PREFIX)/bin/mkfs.sharebox
