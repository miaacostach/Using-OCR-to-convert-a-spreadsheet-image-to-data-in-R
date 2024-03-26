


library(tidyverse)
library(magick)
library(tesseract)


team_str <- image_read("C:\\Users\\macosta\\Downloads\\Capture1.PNG") %>% 
  image_resize('2000x') %>%
  image_convert(type = 'Grayscale') %>%
  image_trim(fuzz = 40) %>%
  image_write(format = 'png', density = '300x300') %>%
  tesseract::ocr() %>%
  strsplit('\n') %>%
  getElement(1)

sapply(team_str, str_split, '\\s+') %>% 
  lapply(t) %>%
  lapply(as.data.frame) %>%
  data.table::rbindlist(fill = TRUE) %>%
  print
