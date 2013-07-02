# The default OS is Linux, if you use this in windows, please change
# "OS = windows". Mac have not be tested.
OS := linux

# Use different command in different OS.
ifeq ("$(OS)","linux")
	CP = cp -rf
	RM = rm -r
else
	CP = copy
	RM = del /q
endif

# Temporary directory
TMP = tmp

all:main.tex data/style.tex data/reference.bib
	test -d $(TMP) || mkdir -p $(TMP) && mkdir -p $(TMP)/data
	xelatex -output-directory=$(TMP) main.tex
	$(CP) data/reference.bib $(TMP)/data/
	cd $(TMP) && bibtex main
	xelatex -output-directory=tmp main.tex
	xelatex -output-directory=tmp main.tex

# Have not contain the reference
debug:main.tex data/article-style.tex
	xelatex -output-directory=$(TMP) main.tex

clean:
	$(RM) $(TMP)
