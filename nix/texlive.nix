{ texlive }:
let
  texliveBasic = {
    inherit (texlive) scheme-basic;
  };

  texliveLanguageSupport = {
    inherit (texlive) babel babel-russian hyphen-russian;
  };

  texliveFonts = {
    inherit (texlive)
      cm-unicode
      fontspec
      mathspec
      jknapltx
      was
      wasy
      starfont
      wasysym
      textcase
      rsfs
      collection-fontsrecommended
      collection-fontutils
      ;
  };

  texliveMaths = {
    inherit (texlive)
      siunitx
      amsmath
      amsfonts
      cancel
      mathtools
      units
      xfrac
      ;
  };

  texliveGraphics = {
    inherit (texlive)
      pdflscape
      graphics
      pgf
      tkz-euclide
      tikz-3dplot
      spath3
      pgfplots
      qrcode
      ;
  };

  texliveLayout = {
    inherit (texlive)
      geometry
      titlesec
      adjustbox
      caption
      pdfpages
      xpatch
      enumitem
      tocloft
      wrapfig
      ;
  };

  texliveUtilities = {
    inherit (texlive)
      xetex
      xcolor
      xifthen
      xurl
      hyperref
      lipsum
      latexmk
      ifmtarg
      ;
  };

  texliveBib = {
    inherit (texlive)
      biblatex
      biblatex-ext
      siunitx
      ;
  };

  texlivePackages =
    texliveBasic
    // texliveLanguageSupport
    // texliveFonts
    // texliveMaths
    // texliveGraphics
    // texliveLayout
    // texliveUtilities
    // texliveBib;
in
texlive.combine texlivePackages
