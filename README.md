# 1. Introduction

This package provides LaTeX classes, bibliography styles and document templates for typesetting dissertations and author's abstracts that satisfy the requirements of dissertation councils and High Certification Commission of Russian Federation.

# 2. Required packages and programs

For installation from sources and compilation of the documents you will need the following third-party packages: `amsfonts`, `amsmath`, `amssymb`, `caption`, `cmap`, `graphicx`, `ifpdf`, `natbib`, `hyperref`, `hypernat`, `subcaption`, `wrapfig`, and packages for russian language support in LaTeX.

For typesetting documents using Times font family you should install the following packages: `pscyr` or `cyrtimes` (text fonts), `newtxmath` or `mtpro2` (math fonts).

For automated processing of figures you should install the following programs: `Ghostscript`, `epstool` and `sam2p`.

# 3. Downloads and updates

- CTAN directory: http://www.ctan.org/tex-archive/macros/latex/contrib/disser/
- Project at Sourceforge: http://sourceforge.net/projects/disser/
- Public source code repositories of this project:
	- https://github.org/polariton/disser/
	- https://bitbucket.org/sky/disser/
	- https://sourceforge.net/p/disser/disser.git

ZIP file with sources can be downloaded from http://www.ctan.org/get/macros/latex/contrib/disser.zip
ZIP file with compiled sources and documentation sorted in a TDS (TeX Directory Structure) tree is available on Sourceforge (see `disser-<version>.tds.zip` file in Downloads section).

# 4. Installation
## 4.1. Installation from ZIP archive in TDS format

This is the easiest and recommended way to install the package. The ZIP file `disser-<version>.tds.zip` contains files sorted in a TDS tree, so you can directly unpack this file to directory with your TeX installation.
Example:
```sh
$ cd /path/to/texmf
$ unzip /download/path/disser-<version>.tds.zip
$ mktexlsr
```

## 4.2. Installation from sources

Enter the following commands in the command prompt:
- in a Unix-like environment:
```sh
$ env DESTDIR=/path/to/texmf make install
```
- in Windows command line prompt:
```sh
$ set DESTDIR=disk:\path\to\texmf
$ nomake install
```
Here `/path/to/texmf` and `disk:\path\to\texmf` are paths to your local TeX directory tree. After installation you should update the filename database with the command 
```sh
$ mktexlsr
```
if you install the package to user's directory `"%APPDATA%\MiKTeX\2.9"` or
```sh
$ mktexlsr --admin
```
if you install the package to one of the common directories, like `"%programfiles%\MiKTeX 2.9"` or `"%ALLUSERSPROFILE%\MiKTeX\2.9"`.

Examples of commands for MiKTeX 2.9.

- Installation for all users:
```sh
$ set DESTDIR=%ALLUSERSPROFILE%\MiKTeX\2.9
$ nomake install
$ mktexlsr --admin
```
- Installation for current user only:
```sh
$ set DESTDIR=%APPDATA%\MiKTeX\2.9
$ nomake install
$ mktexlsr
```

# 5. License

Copyright (c) Stanislav Kruchinin

It may be distributed and/or modified under the conditions of the LaTeX Project Public License, either version 1.3 of this license or (at your option) any later version. The latest version of this license is in http://www.latex-project.org/lppl.txt and version 1.3 or later is part of all distributions of LaTeX version 2003/12/01 or later.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.