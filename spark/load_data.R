library(condensr)
library(dplyr)
library(googlesheets4)

staff_csv <- read_sheet("https://docs.google.com/spreadsheets/d/1sVQZRazo_zGcQkgP_WhMsIEhnye1Cr4l5b8Tqi8pVq8/edit#gid=303417326") %>%
    filter(!is.na(id))

staff_list <- lapply(1:nrow(staff_csv), function(i) {
    member <- staff_member(
        id = staff_csv[i, "id"] %>% pull(),
        name = staff_csv[i, "name"] %>% pull(),
        description = staff_csv[i, "description"] %>% pull(),
        external_link = staff_csv[i, "external_link"] %>% pull(),
        internal_link = staff_csv[i, "internal_link"] %>% pull()
    )
    member[["staff_type"]] <- staff_csv[i, "staff_type"]

    return(member)
})
names(staff_list) <- staff_csv[, "id"] %>% pull()

project_list <- list()



publication_csv <- read_sheet("https://docs.google.com/spreadsheets/d/1VIFfbKhJBtZJQX91CAceiBEJSeMs9CbpUe_qclfS4GM/edit#gid=0")

publication_list <- lapply(1:nrow(publication_csv), function(i) {
    publication(
        title = publication_csv[i, "title"] %>% pull(),
        related_staff = stringr::str_trim(stringr::str_split(publication_csv[i, "related_staff"], ",")[[1]]),
        link = publication_csv[i, "link"] %>% pull(),
        citation = publication_csv[i, "citation"] %>% pull(),
        date = as.Date(publication_csv[i, "date"] %>% pull())
    )
})
