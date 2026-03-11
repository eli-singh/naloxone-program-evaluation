library(readr)
library(tidyverse)

# load data
panel <- read_csv("data/panel_data.csv")
panel_avg <- panel |>
  group_by(county) |>
  summarise(
    baseline = mean(overdose_rate[year %in% 2018:2020], na.rm = TRUE),
    followup = mean(overdose_rate[year %in% 2021:2023], na.rm = TRUE),
    naloxone_intensity = first(kits_per_100k_2018_2025),
    urban_rural = first(urban_rural_code)
  ) |>
  mutate(delta_overdose = followup - baseline)
panel_avg <- panel_avg %>%
  mutate(naloxone_1000 = naloxone_intensity / 1000)


model_1 <- lm(delta_overdose ~ naloxone_1000 + baseline + factor(urban_rural), data = panel_avg)
summary(model_1)

panel_avg <- panel_avg %>%
  mutate(log_change = log(followup + 0.1) -
           log(baseline + 0.1))
model_2 <- lm(log_change ~ naloxone_1000 + baseline + factor(urban_rural), data = panel_avg)
summary(model_2)

