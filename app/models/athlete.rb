# frozen_string_literal: true

# The Athlete model is the main form of data storage in the app,
# containing all pertinent information for each Olympian and their efforts.
class Athlete < ApplicationRecord
  validates_presence_of :name, :sex, :age, :team, :games, :sport, :event
end
