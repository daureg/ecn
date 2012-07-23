all: sting

sting: checkpoint.rst
	sed -i "s/'/’/g" checkpoint.rst
	rst2html.py checkpoint.rst > rst.htm
	#rst2xetex.py --use-latex-docinfo -t --documentclass=scrartcl -l fr checkpoint.rst > check.tex
	#xelatex check.tex
	#xelatex check.tex
	#pandoc -f rst -t html5 -S --toc -s checkpoint.rst -o pandoc.html
	pandoc -f rst -t odt checkpoint.rst -o pandoc.odt
	#pandoc -f rst -t rtf -S --toc -s checkpoint.rst -o pandoc.rtf
	#pandoc -f rst -t docx -S --toc -s checkpoint.rst -o pandoc.docx
	#pandoc -f rst -t latex -S --latex-engine=xelatex -s checkpoint.rst -o native.pdf
	#pandoc -f rst -t native -S --toc -N --bibliography=rapport.bib --normalize checkpoint.rst -o native.hs
	#pandoc -f native -t latex -s --latex-engine=xelatex -S --toc -N --bibliography=rapport.bib --normalize native.hs -o native.pdf
	sed -i "s/’/'/g" checkpoint.rst

clean:
	rm -f check.* native.pdf
