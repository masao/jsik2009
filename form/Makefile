# $Id$

RSYNC=$(HOME)/cvswork/public_html/rsync.pl

# Rsync to http://etk.sakura.ne.jp/
rsync:
	$(RSYNC) etk:www/jsik2009/cfp/data/ ./cfp/data/
	$(RSYNC) etk:www/jsik2009/submit/data/ ./submit/data/
	$(RSYNC) ./ etk:www/jsik2009/

zip: clean
	-mkdir -p jsik/kenkyu/2009/
	sed -e 's/\(href="\)http:\/\/wwwsoc.nii.ac.jp\/jsik\//\1..\/..\//g' index.html > ./jsik/kenkyu/2009/index.html
	cp -p program.pdf style.css ./jsik/kenkyu/2009/
	cp -p kenkyu.html ./jsik/
	zip -9r jsik.zip ./jsik/
	-rm -rf ./jsik/

clean:
	-rm -rf jsik jsik.zip
