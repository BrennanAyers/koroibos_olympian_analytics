# frozen_string_literal: true

require 'csv'

namespace :import do
  desc 'Imports Olympian records from CSV in db/csv'
  task olympians: :environment do
    olympian_count = 0
    CSV.foreach('./db/csv/olympian.csv', headers: true) { olympian_count += 1 }
    index = 0
    CSV.foreach('./db/csv/olympian.csv', headers: true) do |olympian|
      index += 1
      print "#{index}/#{olympian_count} ".light_blue
      if Olympian.create(
        name: olympian['Name'],
        sex: olympian['Sex'],
        age: olympian['Age'],
        height: olympian['Height'] == 'NA' ? nil : olympian['Height'],
        weight: olympian['Weight'] == 'NA' ? nil : olympian['Weight'],
        team: olympian['Team'],
        games: olympian['Games'],
        sport: olympian['Sport'],
        event: olympian['Event'],
        medal: olympian['Medal'] == 'NA' ? nil : olympian['Medal']
      )
        puts "#{olympian['Name']}: #{olympian['Event']}".green
      else
        puts "#{olympian['name']}: #{olympian['Event']} was unable to be saved".red
      end
    end
  end
end
