Insert new code chunk (R, bash, python, etc. available) This is an
example of R code. include=FALSE will disregard this code chunk in knit

Can use R chunk for figures

``` r
data("mtcars")
library(ggplot2)
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point() 
```

![](RMarkdownTut_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->

## R Markdown formatting options

# First level header

example text

## Second level header

#### style and emphasis

### Third level header

*This text is italicized*

**This text is bolded**

- one list item
- two list items
  - one subitem
