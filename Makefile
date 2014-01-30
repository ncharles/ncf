all: clean test doc

test:
	cd tests/style/ && ./testall
	cd tests/unit/ && ./testall
	cd tests/acceptance/ && ./testall --no-network
	cd tests/acceptance/ && ./testall

doc:
	ls tree/30_generic_methods/*.cf | xargs egrep -h "^\s*bundle\s+agent\s+" | sed -r "s/\s*bundle\s+agent\s+//" | sort > doc/all_generic_methods.txt
	tools/ncf_doc.py

html: doc
	# To use this, run pip install pelican Markdown
	cp doc/generic_methods.md site/content/
	cd site; make html

testsite: html
	cd site; make serve

clean:
	rm -rf tests/style/.succeeded
	rm -f tests/style/summary.log
	rm -f tests/style/test.log
	rm -f tests/style/test.xml
	rm -f tests/style/xml.tmp
	rm -rf tests/style/workdir/
	rm -rf tests/acceptance/.succeeded
	rm -f tests/acceptance/summary.log
	rm -f tests/acceptance/test.log
	rm -f tests/acceptance/test.xml
	rm -f tests/acceptance/xml.tmp
	rm -rf tests/acceptance/workdir/
	rm -f doc/all_generic_methods.txt
	rm -f doc/generic_methods.md
	find $(CURDIR) -iname "*.pyc" -delete

distclean: clean

.PHONY: all test doc clean distclean
