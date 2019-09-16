# Koroibos Olympian Analytics Platform
[![Build Status](https://travis-ci.com/BrennanAyers/koroibos_olympian_analytics.svg?branch=master)](https://travis-ci.com/BrennanAyers/koroibos_olympian_analytics)

## Details

To be written...

## Database Models
Our main storage of information is done through the Olympians table. An Olympian resource currently has the following required attributes:
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
We have written convenient Rake tasks to facilitate the process of importing records into the database. Currently, this requires the file to be placed in the `db/csv` directory, with a specific name. For the Olympians table:
- File named `olympian.csv`
- `rake import:olympians` in your terminal

This import task will work with CSVs formatted following the above specification for the Olympian resource, with missing Height, Weight, or Medal attributes marked with an `NA`.

## Endpoints
###### Note: We are using the [FastJSON API](https://github.com/Netflix/fast_jsonapi) library to serialize our information. That means that all responses will be nested inside of a `data` array, and objects might have an `id` of `null` because of how our Olympian data is collated.
### GET `api/v1/olympians`
- This GET request returns a collection of all stored Olympians, serialized to include the following information:
- - Name
- - Team
- - Age
- - Sport
- - Total Number of Medals Won
- Example Request:
```
GET api/v1/olympians
```
- Example Response:
```json
{
  "data": [
    {
      "id": null,
      "type": "olympian",
      "attributes": {
          "name": "  Gabrielle Marie \"Gabby\" Adcock (White-)",
          "team": "Great Britain",
          "age": 25,
          "sport": "Badminton",
          "total_medals_won": 0
      }
    },
    {
      "id": null,
      "type": "olympian",
      "attributes": {
          "name": " Th Anh",
          "team": "Vietnam",
          "age": 20,
          "sport": "Fencing",
          "total_medals_won": 0
      }
    },
    ...
  ]
}
```
### GET `api/v1/olympians?age=YOUNGEST_OR_OLDEST`
- This GET request returns the Youngest or Oldest in Age of all stored Olympians, serialized to include the following information:
- - Name
- - Team
- - Age
- - Sport
- - Total Number of Medals Won
- Example Request:
```
GET api/v1/olympians?age=youngest
```
- Example Response:
```json
{
  "data": [
    {
      "id": null,
      "type": "olympian",
      "attributes": {
        "name": "Ana Iulia Dascl",
        "team": "Romania",
        "age": 13,
        "sport": "Swimming",
        "total_medals_won": 0
      }
    }
  ]
}
```
- Example Request:
```
GET api/v1/olympians?age=oldest
```
- Example Response:
```json
{
  "data": [
    {
      "id": null,
      "type": "olympian",
      "attributes": {
        "name": "Julie Brougham",
        "team": "New Zealand",
        "age": 62,
        "sport": "Equestrianism",
        "total_medals_won": 0
      }
    }
  ]
}
```

## Contributing
- Koroibos Olympian Analytics uses Travis CI to ensure project stability. Travis is one of our required checks, and is performed on new PRs. Your code can not be merged in if there are failing specs.
- We also use Hound CI to maintain code style across the repo. We have a custom configuration to avoid false positives in Spec files, Rake tasks, and Database configurations. Otherwise, please ensure all contributions follow the [Ruby Style Guide](https://rubystyle.guide/).
- When writing new code, make sure that you check the Coverage in `coverage/index.html` provided by SimpleCov. We don't believe that code coverage is the be all end all of code quality, but it does help to point out any glaring issues.
