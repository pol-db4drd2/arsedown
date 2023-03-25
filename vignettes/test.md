---
title: "test"
subtitle: "(20) Texas 34 (11) Oklahoma St 41"
author: Gordon Arsenoff
date: "2022-10-31"
output: 
  arsedown::pdf_memo:
  # bookdown::pdf_book:
    smolhead:         true
    keep_md:          TRUE
    keep_tex:         TRUE
    toc:             FALSE
    toc_depth:           2
    number_sections: FALSE
fontfamily: fourier
fontsize: 11pt
geometry: top=0.55in, bottom=0.55in, left=0.65in, right=0.65in
bibliography: "/home/arsenoff/R/x86_64-pc-linux-gnu-library/4.2/arsedown/include/arsenoff.bib"
csl: "apsa.csl"
subparagraph: true
linkcolor: blue
vignette: >
  %\VignetteIndexEntry{test}
  %\VignetteEngine{knitr::rmarkdown}
  %\VignetteEncoding{UTF-8}
knit: (function(input_file, encoding, ...) {rmarkdown::render(input_file, encoding=encoding, clean=FALSE)})
---





# Foo

[@kingtomzwittenberg2000]

@campbelletal1960

## Bar

### Superman

### Batman

## Baz

### Captain America

#### The First Avenger

This is paragraph-level text.

#### The Winter Soldier

##### Lorem ipsum

This is subparagraph-level text.

##### Dolor sit amet

### Iron Man

# Quux





\clearpage

# References
