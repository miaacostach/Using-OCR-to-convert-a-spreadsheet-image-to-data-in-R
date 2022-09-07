

library(dplyr)
library(magick)
library(tesseract)

df <- "https://i.stack.imgur.com/V9lWV.png" %>%
  image_read() %>%
  image_resize('2000x') %>%
  image_convert(type = 'Grayscale') %>%
  image_trim(fuzz = 40) %>%
  image_write(format = 'png', density = '300x300') %>%
  tesseract::ocr() %>%
  strsplit('\n') %>%
  getElement(1) %>%
  `[`(-1) %>%
  {sub('Time 2', 'Time_2', .)} %>%
  {read.table(text = .)} %>%
  setNames(c('Time_factor', 'Tree #', 'Species', 'Fragment', 
             'Linear Extension(mm)', 'Colour'))

