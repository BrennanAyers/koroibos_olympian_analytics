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

## Setup
### Requirements
- Brew Package Manager
- Git
- PostgreSQL
- Ruby Version: `2.4.1`
- Rails Version: `5.2.3`

<details><summary><b>Brew Installation</b></summary>
<p>

[Brew](https://brew.sh/) is a package manager for Mac OS (or Linux) that allows us to install libraries using easy and convenient terminal commands. We need Brew to install later required elements of the Koroibos Olympian Analytics Server. To install Brew on a Mac OS machine, run in your terminal:
```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
For Linux instructions, refer [here](https://docs.brew.sh/Homebrew-on-Linux).
</p>
</details>

<details><summary><b>Git Installation</b></summary>
<p>

If you're on GitHub, you're halfway to knowing what Git is! Git is a 'version control system' that tracks changes to code, stored in what is generally called a 'repository'. GitHub is a remote hosting service of these repositories, and you're looking at one right now!
There are many ways to install and use Git:
- Brew `brew install git`
- [Desktop Client](https://desktop.github.com/)
- [Installable Source](https://git-scm.com/downloads) for Mac, Windows, Linux
- - Further instructions [here](https://help.github.com/en/articles/setting-your-username-in-git) and [here](https://help.github.com/en/articles/setting-your-commit-email-address)
</p>
</details>

<details><summary><b>Rbenv Installation</b></summary>
<p>

[rbenv](https://github.com/rbenv/rbenv) is an environment manager for the Ruby language that allows us to install and control multiple versions of Ruby on our computer. We can use Brew to install rbenv in our terminal:
```bash
brew install rbenv
rbenv init
```
The terminal will now instruct you to input some shortcuts for rbenv in your `~/.bash_profile`:
- `nano ~/.bash_profile` (or your preferred command line text editor)
- CMD+V/CTRL-V `eval "$(rbenv init -)"` - to paste the shortcut
- CTRL+X - to quit Nano
- Y - to save the file
- `source ~/.bash_profile`
- `curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash`
- The last command will determine if your rbenv setup was successful. If you run into issues installing rbenv, I would suggest checking out their [issues board](https://github.com/rbenv/rbenv/issues), or Googling any specific errors on Google.
- Lastly, install Ruby 2.4.1 for use in this app:
```bash
rbenv install 2.4.1
```
- If you are unable to use Brew, refer to [this section](https://github.com/rbenv/rbenv#basic-github-checkout) of the rbenv documentation.
</p>
</details>

<details><summary><b>PostgreSQL Installation</b></summary>
<p>

[Postgres](https://en.wikipedia.org/wiki/PostgreSQL) is a relational database management system that we use to store information in the Koroibos Olympian Analytics Server. All of the set up will be handled by Rails once we get to that step, but Postgres does need to be installed for that to happen. We highly suggest using Brew for this part of the process, but in the situation where Brew is not available, [these](https://www.postgresql.org/docs/current/install-getsource.html) are the instructions.
- For a Brew installation:
```bash
brew install postgresql
brew services start postgresql
psql postgres
```
</p>
</details>

- All below commands are to be run in your terminal or command line of choice.

To get the the Koroibos Olympian Analytics Server application up and running on your local machine, start by getting the source code from this GitHub repository:
```bash
git clone git@github.com:BrennanAyers/koroibos_olympian_analytics.git (for SSH)
cd koroibos_olympian_analytics
```
The Koroibos Olympian Analytics Server uses the `bundler` library to manage dependencies. This process will take some time to install all of the correct versions of the libraries we use. After cloning down the repo with the above commands:
```bash
bundler install
```
After Bundler installs all required packages, run in the the Koroibos Olympian Analytics Server directory:
```bash
rails db:create
rails db:migrate
```
Now that our application files are sorted, and the database has pertinent information inside of it, we can start the application:
```bash
rails server
```
This will begin the server on your `localhost:`, generally on Port 3000. Now that that you have the game server up and running, you can interact with it through the Endpoints below.

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
