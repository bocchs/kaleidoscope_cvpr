# https://tex.stackexchange.com/questions/40738/how-to-properly-make-a-latex-project

.PHONY: pyramid.pdf supplement.pdf derivations.pdf all clean

all: pyramid supplement derivations

# CUSTOM BUILD RULES

# In case you didn't know, '$@' is a variable holding the name of the target,
# and '$<' is a variable holding the (first) dependency of a rule.
# "raw2tex" and "dat2tex" are just placeholders for whatever custom steps
# you might have.

%.tex: %.raw
	./raw2tex $< > $@

%.tex: %.dat
	./dat2tex $< > $@

# MAIN LATEXMK RULE

# -pdf tells latexmk to generate PDF directly (instead of DVI).
# -pdflatex="" tells latexmk to call a specific backend with specific options.
# -use-make tells latexmk to call make for generating missing files.

# -interaction=nonstopmode keeps the pdflatex backend from stopping at a
# missing file reference and interactively asking you for an alternative.


pyramid: pyramid.pdf
	latexmk -pdf -pdflatex="pdflatex -interaction=nonstopmode" -use-make main.tex

supplement: supplement.pdf
	latexmk -pdf -pdflatex="pdflatex -interaction=nonstopmode" -use-make supplement.tex

derivations: derivations.pdf
	latexmk -pdf -pdflatex="pdflatex -interaction=nonstopmode" -use-make derivations.tex

clean:
	latexmk -CA
	rm *.bbl
