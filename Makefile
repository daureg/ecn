all: sting

sting: checkpoint.rst
	rst2xetex2 -t --documentclass=scrartcl -l fr checkpoint.rst > check.tex
	xelatex check.tex
	rst2html2 checkpoint.rst > ~/checkpoint.htm

clean:
	rm -f check.*
