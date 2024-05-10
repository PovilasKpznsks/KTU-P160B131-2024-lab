library(tidyverse)
library(jsonlite)
setwd("C:/Users/Home/Desktop/2 lab r/KTU-P160B131-2024-lab/data")
cat("Darbinė direktorija:", getwd())

download.file("https://atvira.sodra.lt/imones/downloads/2023/monthly-2023.json.zip", "../data/temp")
unzip("../data/temp",  exdir = "../data/")
readLines("../data/monthly-2023.json", 20)

data = fromJSON("../data/monthly-2023.json")

data %>%
  filter(ecoActCode == 862300) %>%
  saveRDS("../data/862300.rds")

file.remove("../data/temp")
file.remove("../data/monthly-2023.json")
file.remove("../img/shiny_example.png")
file.remove("../img/pavyzdys1.png")
file.remove("../img/pavyzdys2.png")
file.remove("../img/pavyzdys3.png")