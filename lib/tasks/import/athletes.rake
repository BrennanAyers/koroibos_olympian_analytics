# frozen_string_literal: true

require 'csv'

namespace :import do
  desc 'Imports Athlete records from CSV in db/csv'
  task athletes: :environment do
    athlete_count = 0
    CSV.foreach('./db/csv/athlete.csv', headers: true) { athlete_count += 1 }
    index = 0
    CSV.foreach('./db/csv/athlete.csv', headers: true) do |athlete|
      index += 1
      print "#{index}/#{athlete_count} ".light_blue
      if Athlete.create(
        name: athlete['Name'],
        sex: athlete['Sex'],
        age: athlete['Age'],
        height: athlete['Height'] == 'NA' ? nil : athlete['Height'],
        weight: athlete['Weight'] == 'NA' ? nil : athlete['Weight'],
        team: athlete['Team'],
        games: athlete['Games'],
        sport: athlete['Sport'],
        event: athlete['Event'],
        medal: athlete['Medal'] == 'NA' ? nil : athlete['Medal']
      )
        puts "#{athlete['Name']}: #{athlete['Event']}".green
      else
        puts "#{athlete['name']}: #{athlete['Event']} was unable to be saved".red
      end
    end
  end
end
