# $Id$

RSYNC=$(HOME)/cvswork/public_html/rsync.pl

# Rsync to http://etk.sakura.ne.jp/
rsync:
	$(RSYNC) etk:www/jsik2009/cfp/data/ ./cfp/data/
	$(RSYNC) etk:www/jsik2009/submit/data/ ./submit/data/
	$(RSYNC) ./ etk:www/jsik2009/

zip: clean
	-mkdir 2009
	cp -p index.html style.css ./2009/
	zip -9r 2009.zip 2009/
	-rm -rf 2009

clean:
	-rm -rf 2009 2009.zip
