.PHONY: clean all docs tests

all: docs tests

docs:
	make -C doc html

tests:
	make -C tests

clean:
	make -C doc clean
	make -C tests clean
	make -C deployment clean
