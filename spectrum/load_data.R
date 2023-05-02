library(condensr)
library(dplyr)
library(googlesheets4)
library(tidyr)
library(readr)

staff_csv <- read_csv(here::here("spectrum/staff_list.csv"))

staff_list <- lapply(1:nrow(staff_csv), function(i) {
    member <- staff_member(
        id = staff_csv[i, "id"] %>% pull(),
        name = staff_csv[i, "name"] %>% pull(),
        description = if_else(
            is.na(staff_csv[i, "role_in_ss"] %>% pull()),
            stringr::str_to_sentence(staff_csv[i, "staff_type"] %>% pull()),
            staff_csv[i, "role_in_ss"] %>% pull()
        ),
        external_link = staff_csv[i, "external_link"] %>% pull(),
        internal_link = staff_csv[i, "internal_link"] %>% pull()
    )
    member[["staff_type"]] <- staff_csv[i, "staff_type"]
    member[["bio"]] <- paste(
        paste("###", staff_csv[i, c("role_in_org", "organisation")], collapse = "\n\n"),
        "\n\n",
        staff_csv[i, "bio"],
        collapse = "\n\n"
    )
    member[["email"]] <- staff_csv[i, "email"]
    member[["consortia"]] <- staff_csv[i, "consortia"]

    return(member)
})
names(staff_list) <- staff_csv[, "id"] %>% pull()



project_list <- list()



publication_csv <- read_csv(here::here("spectrum/publication_list.csv"))

publication_list <- lapply(1:nrow(publication_csv), function(i) {
    publication(
        title = publication_csv[i, "title"] %>% pull(),
        related_staff = stringr::str_trim(stringr::str_split(publication_csv[i, "related_staff"], ",")[[1]]),
        link = publication_csv[i, "link"] %>% pull(),
        citation = publication_csv[i, "citation"] %>% pull(),
        date = as.Date(publication_csv[i, "date"] %>% pull())
    )
})

publication_list <- publication_list[
    order(sapply(publication_list, "[[", "date"), decreasing = TRUE)
]
