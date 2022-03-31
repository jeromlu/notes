# Brachytherapy personal notes

The latex source files are in the directory `src`. Required figures are located
in the `figures` directory.

The source files (`.tex`) are compiled using [latexmk](
https://mg.readthedocs.io/latexmk.html) using `lualatex` and `pdf` output.

## Prerequisites

In order to be able to compile the latex, and run `compile_book.ps1` script
following tools have to be installed:

  - [TeX Live](https://www.tug.org/texlive/) - to compile the latex document.
  - [SumatraPdf](https://www.sumatrapdfreader.org/free-pdf-reader) - for
      viewing of produced *pdf*.

Everything has to be on the system `PATH`.

## Compile/view the book

To compile latex source files simple *Power shell* build script is provided (works only on
Windows).

The script has to be run from the root folder of the project.

Basic usage:
```
$ ./compile_book.ps1
```

All output files are generated in newly created `build` folder in the root of
the project.

To compile and show created pdf.
```
$ ./compile_book.ps1 -ShowPdf
```

After compilation the pdf is opened in *SumatraPdf.exe*.

To remove all build/compilation related directories:

```
$ ./compile_book.ps1 -Clean
```
