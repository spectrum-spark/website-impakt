library(googledrive)

drive <- shared_drive_find("SPECTRUM-SPARK Website")

staff_pictures <- drive %>%
    drive_ls() %>%
    filter(name == "images") %>%
    pull(id) %>%
    drive_ls() %>%
    pull(id) %>%
    drive_ls()

# Clean out directory
unlink(list.files(here::here("spectrum", "images", "staff"), full.names = T))
for (i in 1:nrow(staff_pictures)) {
    drive_download(
        staff_pictures[i, "id"] %>% pull(),
        path = here::here("spectrum", "images", "staff", staff_pictures[i, "name"] %>% pull()),
        overwrite = T
    )
}
