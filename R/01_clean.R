library(tidyverse)
library(stringr)

naloxone <- read.csv("data/naloxone_county_raw.csv")
mortality <- read.csv("data/overdose_wonder_county_year.csv")
urban_rural <- read.csv("data/urban_rural_county.csv")

mortality_clean <- mortality |>
  rename(county = Residence.County,
         fips = Residence.County.Code,
         year = Year,
         deaths = Deaths,
         population = Population,
         overdose_rate = Crude.Rate) |>
  select(county, fips, year, deaths, population, overdose_rate) |>
  mutate(county = str_remove(county, " County, CA"),
         county = str_trim(county))

naloxone <- naloxone %>%
  mutate(county = str_trim(county))
naloxone <- naloxone %>%
  mutate(
    kits_per_100k_2018_2025 = str_replace_all(kits_per_100k_2018_2025, ",", ""),
    kits_per_100k_2018_2025 = as.numeric(kits_per_100k_2018_2025)
  )

all_data <- mortality_clean |>
  left_join(naloxone, by = "county") |>
  left_join(urban_rural |> select(fips, urban_rural_code), by = "fips")


panel <- all_data |>
  filter(year %in% 2018:2023)

write.csv(panel, "data/panel_data.csv", row.names = FALSE)