# Koroibos Olympian Analytics Platform

## Details

To be written...

## Database Models
Our main storage of information is done through the Athletes table. An Athlete resource currently has the following required attributes:
- Name `String`
- Sex `String`
- Age `Integer`
- Team `String`
- Games `String`
- Sport `String`
- Event `String`

And the following non-required attribute:
- Height `Integer`
- Weight `Integer`
- Medal `String`

## Data Importing
We have written convenient Rake tasks to facilitate the process of importing records into the database. Currently, this requires the file to be placed in the `db/csv` directory, with a specific name. For the Athletes table:
- File named `athlete.csv`
- `rake import:athletes` in your terminal

This import task will work with CSVs formatted following the above specification for the Athlete resource, with missing Height, Weight, or Medal attributes marked with an `NA`.
