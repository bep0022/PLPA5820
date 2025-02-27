# Dummy Demonstration Repository

This is a dummy README to demonstrate directory structure, file trees,
linking dois, and editing a README.md file

# DOI

[![DOI](https://zenodo.org/badge/924882346.svg)](https://doi.org/10.5281/zenodo.14934722)

## Links to analysis (or in my case, coding challenges)

These are the links to the analysis files viewable on GitHub (.md), the
.Rmd files, and .HTML rendered files are also available

- [Coding Challenge 1](CodingChallenge1.R)
- [Coding Challenge 2](CodingChallenge2.R)

## File Tree - tree() on terminal or here on R

``` r
install.packages("rmarkdown")
```

    ## Error in install.packages : Updating loaded packages

``` r
install.packages("knitr")
```

    ## Error in install.packages : Updating loaded packages

``` r
install.packages("fs")
```

    ## Error in install.packages : Updating loaded packages

``` r
library(fs)
fs::dir_tree()
```

    ## .
    ## ├── CodingChallenge1.R
    ## ├── CodingChallenge2.R
    ## ├── CodingChallenge3.R
    ## ├── DataVisualization1.R
    ## ├── DataVisualization2.R
    ## ├── Dummy_README.Rmd
    ## ├── Dummy_README.html
    ## ├── Dummy_README.md
    ## ├── HHHHH.jpg
    ## ├── IntroToR.R
    ## ├── PLPA5820.Rproj
    ## ├── README.md
    ## ├── RMarkdownTut.Rmd
    ## ├── RMarkdownTut.html
    ## ├── RMarkdownTut.md
    ## └── RMarkdownTut_files
    ##     └── figure-gfm
    ##         ├── pressure-1.png
    ##         └── unnamed-chunk-1-1.png
