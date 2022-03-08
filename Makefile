FILENAME=robotarm
PDFLATEX=pdflatex -interaction=nonstopmode --shell-escape
CLEAN_EXTS = *.log *.aux *.nav *.fls *.fdb_latexmk *.snm *.toc *.vrb *.out *.synctex.gz *.pyg *.glo *.gls *.idx *.ind *.ilg *.bbl *.bcf *.blg *.hd *.tcbtemp *.run.xml

all: sty
	$(PDFLATEX) $(FILENAME).dtx
	biber $(FILENAME)
	$(PDFLATEX) $(FILENAME).dtx
	makeindex -q -s gind.ist -o $(FILENAME).ind $(FILENAME).idx
	makeindex -q -s gglo.ist -o $(FILENAME).gls $(FILENAME).glo
	$(PDFLATEX) $(FILENAME).dtx
	$(PDFLATEX) $(FILENAME).dtx

sty:
	tex $(FILENAME).ins

quick: sty
	$(PDFLATEX) $(FILENAME).dtx

clean:
ifeq ($(OS), Windows_NT)
	del /s /q $(CLEAN_EXTS)
	del /s /q $(FILENAME).sty $(FILENAME).doc.* 
	- for /f %%i in ('dir /a:d /s /b _minted*') do rmdir /s /q %%i
else
	rm -r -f $(CLEAN_EXTS)
	rm -r -f $(FILENAME).sty $(FILENAME).doc.* 
	rm -r -f _minted*
endif
