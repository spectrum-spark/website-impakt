library(condensr)
library(dplyr)

staff_csv <- read.csv("staff_list.csv", na.strings = c("NA", "")) %>%
    filter(!is.na(id))

staff_list <- lapply(1:nrow(staff_csv), function(i) {
    member <- staff_member(
        id = staff_csv[i, "id"],
        name = staff_csv[i, "name"],
        description = staff_csv[i, "description"],
        external_link = staff_csv[i, "external_link"],
        internal_link = staff_csv[i, "internal_link"]
    )
    member[["staff_type"]] <- staff_csv[i, "staff_type"]

    return(member)
})
names(staff_list) <- staff_csv[, "id"]

project_list <- list()

publication_csv <- read.csv("publication_list.csv", na.strings = c("NA", ""))

publication_list <- lapply(1:nrow(publication_csv), function(i) {
    publication(
        title = publication_csv[i, "title"],
        related_staff = stringr::str_split(publication_csv[i, "related_staff"], ",")[[1]],
        link = publication_csv[i, "link"],
        citation = publication_csv[i, "citation"],
        date = as.Date(publication_csv[i, "date"])
    )
})