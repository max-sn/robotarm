FILENAME=robotarm
PDFLATEX=pdflatex -interaction=nonstopmode --shell-escape
CLEAN_EXTS = *.log *.aux *.nav *.fls *.fdb_latexmk *.snm *.toc *.vrb *.out *.synctex.gz *.pyg *.glo *.gls *.idx *.ind *.ilg *.bbl *.bcf *.blg *.hd *.tcbtemp *.run.xml
VERSION:=$(shell git describe)

all: sty
	$(PDFLATEX) $(FILENAME).dtx
	biber $(FILENAME)
	$(PDFLATEX) $(FILENAME).dtx
	makeindex -q -s gind.ist -o $(FILENAME).ind $(FILENAME).idx
	makeindex -q -s gglo.ist -o $(FILENAME).gls $(FILENAME).glo
	$(PDFLATEX) $(FILENAME).dtx
	$(PDFLATEX) $(FILENAME).dtx

package: clean all
	zip robotarm-$(VERSION).zip README.md robotarm.dtx robotarm.pdf robotarm.sty

sty:
	tex $(FILENAME).ins

quick: sty
	$(PDFLATEX) $(FILENAME).dtx

clean:
	rm -rf $(CLEAN_EXTS)
	rm -rf $(FILENAME).sty $(FILENAME).doc.*
	rm -rf _minted*
