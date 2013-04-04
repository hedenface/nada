INSTALLPATH=/opt/nada
CC=gcc
LIBS=-lm -lmysqlclient
LIBSSQLITE=-lm -lsqlite3
CFLAGS=-g -L/usr/lib64/mysql -L/usr/lib/mysql -Wall
MACROS=-D"INSTALLPATH=\"$(INSTALLPATH)\""
SQLITEMACROS=-D"INSTALLPATH=\"$(INSTALLPATH)\"" -D"SQLITE"

all: baseline

baseline: 
	$(CC) $(CFLAGS) $(LIBS) $(MACROS) -o nada dblayer.c baseline.c iniparser/iniparser.c iniparser/dictionary.c
	$(CC) $(CFLAGS) $(LIBS) $(MACROS) -o purge-db-data purge-db-data.c dblayer.c iniparser/iniparser.c iniparser/dictionary.c

baselinesqlite: 
	$(CC) $(LIBSSQLITE) $(SQLITEMACROS) -o nada dblayer-sqlite.c baseline.c iniparser/iniparser.c iniparser/dictionary.c
	#$(CC) $(LIBSSQLITE) $(SQLITEMACROS) -o purge-db-data purge-db-data.c dblayer.c iniparser/iniparser.c iniparser/dictionary.c

clean:
	rm -rf nada 
	rm -rf purge-db-data

install:
	mkdir -p $(INSTALLPATH) 
	cp -Rfp nada $(INSTALLPATH)
	cp -Rfp baseline.ini $(INSTALLPATH)
	cp -Rfp purge-db-data $(INSTALLPATH)

uninstall:
	rm -rf $(INSTALLPATH)
