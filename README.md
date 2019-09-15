# Koroibos Olympian Analytics Platform
[![Build Status](https://travis-ci.com/BrennanAyers/koroibos_olympian_analytics.svg?branch=master)](https://travis-ci.com/BrennanAyers/koroibos_olympian_analytics)

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

## Contributing
- Koroibos Olympian Analytics uses Travis CI to ensure project stability. Travis is one of our required checks, and is performed on new PRs. Your code can not be merged in if there are failing specs.
- We also use Hound CI to maintain code style across the repo. We have a custom configuration to avoid false positives in Spec files, Rake tasks, and Database configurations. Otherwise, please ensure all contributions follow the [Ruby Style Guide](https://rubystyle.guide/).
- When writing new code, make sure that you check the Coverage in `coverage/index.html` provided by SimpleCov. We don't believe that code coverage is the be all end all of code quality, but it does help to point out any glaring issues.
