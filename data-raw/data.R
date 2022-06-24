library(maps)
library(dplyr)
library(wppExplorer)


data(iso3166)
iso3166 %>%
    dplyr::select(name, charcode) -> iso_codes

df <- tidyiddr::cache_download("https://covid.ourworldindata.org/data/owid-covid-data.csv")


country_options <- unique(df$location[df$location %in% iso_codes$name])

usethis::use_data(iso_codes, df, country_options, overwrite = T)