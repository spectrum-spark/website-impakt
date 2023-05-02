library(dplyr)
library(googlesheets4)
library(tidyr)
library(readr)

staff_csv <- read_sheet("https://docs.google.com/spreadsheets/d/1sVQZRazo_zGcQkgP_WhMsIEhnye1Cr4l5b8Tqi8pVq8/edit#gid=303417326") |>
    filter(!is.na(id)) |>
    separate_longer_delim(c(staff_type, consortia), delim = ",")

write_csv(
    x = staff_csv |>
        filter(consortia == "spectrum"),
    file = here::here("spectrum/staff_list.csv")
)

write_csv(
    x = staff_csv |>
        filter(consortia == "spark"),
    file = here::here("spark/staff_list.csv")
)

project_list <- list()



publication_csv <- read_sheet("https://docs.google.com/spreadsheets/d/1VIFfbKhJBtZJQX91CAceiBEJSeMs9CbpUe_qclfS4GM/edit#gid=0")

write_csv(
    x = publication_csv,
    file = here::here("spectrum/publication_list.csv")
)

write_csv(
    x = publication_csv,
    file = here::here("spark/publication_list.csv")
)
