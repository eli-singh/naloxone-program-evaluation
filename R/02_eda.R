library(tidyverse)

panel <- read.csv("data/panel_data.csv") 

# compare average overdose rates from 2018-2020 and 2021-2023
panel_avg <- panel |>
  group_by(county) |>
  summarise(
    baseline = mean(overdose_rate[year %in% 2018:2020], na.rm = TRUE),
    followup = mean(overdose_rate[year %in% 2021:2023], na.rm = TRUE),
    naloxone_intensity = first(kits_per_100k_2018_2025),
    urban_rural = first(urban_rural_code)
  ) |>
  mutate(delta_overdose = followup - baseline)

summary(panel_avg$delta_overdose)

# baseline vs followup
ggplot(panel_avg, aes(x = baseline, y = followup)) +
  geom_point() +
  geom_abline(slope = 1, intercept = 0, linetype = "dashed") +
  theme_minimal() +
  labs(title = "Baseline vs Follow-up Overdose Rates",
       x = "Baseline (2018–2020 Avg)",
       y = "Follow-up (2021–2023 Avg)")

ggsave("output/figures/baseline_vs_followup.png",
       width = 6, height = 5)

# change in mortality
ggplot(panel_avg, aes(x = delta_overdose)) +
  geom_histogram(bins = 20) +
  theme_minimal() +
  labs(title = "Change in Overdose Rate",
       x = "Change (Follow-up − Baseline)",
       y = "Count")

ggsave("output/figures/delta_distribution.png",
       width = 6, height = 5)

# naloxone intensity
ggplot(panel_avg, aes(x = naloxone_intensity)) +
  geom_histogram(bins = 20) +
  theme_minimal() +
  labs(title = "Naloxone Kits Distribution Intensity",
       x = "Naloxone Kits per 100k (2018–2025)",
       y = "Count")

ggsave("output/figures/naloxone_distribution.png",
       width = 6, height = 5)

# naloxone intensity vs change in overdose
ggplot(panel_avg, aes(x = naloxone_intensity, y = delta_overdose)) +
  geom_point() +
  geom_smooth(method = "lm") +
  theme_minimal() +
  labs(title = "Naloxone Distribution vs Change in Overdose Rate",
       x = "Naloxone Kits per 100k",
       y = "Change in Overdose Rate")

ggsave("output/figures/naloxone_vs_delta.png",
       width = 6, height = 5)

# urban vs rural
ggplot(panel_avg, aes(x = factor(urban_rural), y = delta_overdose)) +
  geom_boxplot() +
  theme_minimal() +
  labs(title = "Change in Overdose Rate by Urban/Rural Category",
       x = "Urban/Rural Code",
       y = "Change in Overdose Rate")

ggsave("output/figures/delta_by_urban.png",
       width = 6, height = 5)

# extreme values
panel_avg |>
  arrange(desc(delta_overdose)) |>
  head(5)

panel_avg |>
  arrange(delta_overdose) |>
  head(5) # only 2 counties with negative change

cor(panel_avg$naloxone_intensity,
    panel_avg$delta_overdose,
    use = "complete.obs")
