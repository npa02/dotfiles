# Guide for setting up Latex in ArchLinux

Check [Arch Wiki](https://wiki.archlinux.org/title/TeX_Live).

- `texlive-basic`, the core installation, based on the medium upstream install scheme. The package includes pacman hooks to automate `mktexlsr`, `fmtutil` and `updmap`.
- `texlive-latex` contains essential `LaTeX` packages.
- `texlive-latexrecommended` and `texlive-latexextra` contain many useful LaTeX packages, such as `polyglossia`, `amsmath` and `graphicx`.
- `texlive-fontsrecommended` contains essential fonts (including the default Latin Modern)
  - `texlive-fontsextra`, `texlive-fontsutils` contain additional fonts, which can be viewed on the `LaTeX` Font Catalogue.
- `texlive-xetex` and `texlive-luatex` contain packages for `XeTeX` and `LuaTeX` respectively.
- `texlive-bibtexextra` contains the BibLaTeX package and additional `BibTeX` styles and bibliography databases.
- `texlive-mathscience` contains essential packages for mathematics, natural sciences and computer science.
- `texlive-lang` group contains packages providing character sets and features for languages with non-Latin characters.
  - `texlive-langgreek` as the dependencies for `textgreek`

## Tips
Tip: If you are missing specific `.sty` files, you can run `pacman -F` to find the Arch package that provides them
