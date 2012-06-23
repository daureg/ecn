all: sting

sting: checkpoint.rst
	rst2html2 checkpoint.rst > ~/checkpoint.htm
	rst2xetex2 --use-latex-docinfo -t --documentclass=scrartcl -l fr checkpoint.rst > check.tex
	xelatex check.tex
	pandoc -f rst -t latex -S --latex-engine=xelatex -s checkpoint.rst -o native.pdf

clean:
	rm -f check.* native.pdf
