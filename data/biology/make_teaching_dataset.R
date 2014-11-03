### This script should be executed from the datacarpentry/data/biology
### folder. It is used to modify the "surveys.csv" and "species.csv"
### files to make them more suitable to teaching.

### Currently, the script renames the species code "NA" to "NL" to
### avoid the ambiguities associated with missing data when reading
### the data in R.

species <- read.csv(file="data_orig/species.csv", na.strings="")
species$species_id <- gsub("^NA$", "NL", species$species_id)
write.csv(species, file="species.csv", row.names=FALSE, na="")

surveys <- read.csv(file="data_orig/surveys.csv", na.strings="")
surveys$species <- gsub("^NA$", "NL", surveys$species)
write.csv(surveys, file="surveys.csv", row.names=FALSE, na="")

## Tests
## In addition of the change from "NA" to "NL":
## - there are now quotes around the column titles
## - digit-only columns are not quoted

orig_species <- readLines("data_orig/species.csv")
new_species <- readLines("species.csv")
diff_species <- setdiff(new_species, orig_species)

stopifnot(identical(diff_species,
                    c("\"species_id\",\"genus\",\"species\",\"taxa\"",
                      "\"NL\",\"Neotoma\",\"albigula\",\"Rodent\"")))

new_surveys <- read.csv("surveys.csv", stringsAsFactors=FALSE)
new_species <- read.csv("species.csv", stringsAsFactors=FALSE)
stopifnot(all(new_surveys$species[nzchar(new_surveys$species)] %in% new_species$species_id))
