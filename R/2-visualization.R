library(tidyverse)
library(plotly)
library(gganimate)
library(htmlwidgets)

data <- readRDS("../data/862300.rds")

# 2.1 uzd, histograma vidutiniam atlyginimui.

hist1 <- ggplot(data = data, aes(x = avgWage)) +
  geom_histogram()

ggsave("../img/1_uzd_grafikas.png", hist1, width = 3000, height = 1500, units = ("px"))

# 2.2 uzd, Išrinkite 5 įmones, kurių faktinis sumokėtas darbo užmokestis per metus buvo didžiausias.

top5 <- data %>%
  group_by(name) %>%
  summarise(dsk = max(avgWage)) %>%
  arrange(desc(dsk)) %>%
  head(5)

top5

hist2 <- data %>%
  filter(name %in% top5$name) %>%
  mutate(month = ym(month)) %>%
  ggplot(aes(x = month, y = avgWage, color = name)) +
  geom_line()

ggsave("../img/2_uzd_grafikas.png", hist2, width = 3000, height = 1500, units = ("px"))

# 2.3 uzd, išrinktų 5 įmonių išrinkite maksimalų apdraustų darbuotojų skaičių.

Insured <- data %>%
  group_by(name) %>%
  summarise(Ins = max(numInsured)) %>%
  arrange(desc(Ins)) %>%
  head(5)

Insured

Insured$name = factor(Insured$name, levels = Insured$name[order(Insured$Ins, decreasing = T)])

hist3 <- Insured %>%
  ggplot(aes(x = name, y = Ins, fill = name)) + 
  geom_col() +
  labs(y  = "apdraustieji")

ggsave("../img/3_uzd_grafikas.png", hist3, width = 6000, height = 1500, units = ("px"))