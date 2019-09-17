# Koroibos Olympian Analytics Platform
[![Build Status](https://travis-ci.com/BrennanAyers/koroibos_olympian_analytics.svg?branch=master)](https://travis-ci.com/BrennanAyers/koroibos_olympian_analytics)

## Details

The Koroibos Olympian Analytics Platform is a final solo project by [Brennan Ayers](https://github.com/BrennanAyers), built in Ruby on Rails, for the [Turing School of Software and Design](https://turing.io) Backend Program, in the style of a coding challenge. All code and [planning boards](https://github.com/BrennanAyers/koroibos_olympian_analytics/projects/1?fullscreen=true) were created in 48 hours as would be required in a job application setting.

The intention of the project was to build a backend API service that takes in a collection of Olympic data and returns it in easy to use Endpoints. This required importing of the information from a CSV and then collating it into a readable output through the use of the ActiveRecord ORM and FastJSON API Serializers.
### Learning Goals
- Project Management
- Clean, Tested Code
- Clear and Concise Documentation
- Time Constraints

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
### GET `api/v1/olympian_stats`
- This GET request returns statistical information for all Olympians stored in the database. This includes the following:
- - Total Olympians Competing
- - Average Weight of Male Olympians (in kg)
- - Average Weight of Female Olympians (in kg)
- - Average Age of all Olympians
- Example Request:
```
GET api/v1/olympian_stats
```
- Example Response:
```json
{
  "data": [
    {
      "id": null,
      "type": "olympian_stats",
      "attributes": {
        "total_competing_olympians": 2850,
        "average_age": "26.2",
        "average_weight": {
          "unit": "kg",
          "male_olympians": "78.6",
          "female_olympians": "61.9"
        }
      }
    }
  ]
}
```

## Contributing
- Koroibos Olympian Analytics uses Travis CI to ensure project stability. Travis is one of our required checks, and is performed on new PRs. Your code can not be merged in if there are failing specs.
- We also use Hound CI to maintain code style across the repo. We have a custom configuration to avoid false positives in Spec files, Rake tasks, and Database configurations. Otherwise, please ensure all contributions follow the [Ruby Style Guide](https://rubystyle.guide/).
- When writing new code, make sure that you check the Coverage in `coverage/index.html` provided by SimpleCov. We don't believe that code coverage is the be all end all of code quality, but it does help to point out any glaring issues.
