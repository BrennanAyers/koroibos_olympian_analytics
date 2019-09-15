# frozen_string_literal: true

# The Olympian model is the main form of data storage in the app,
# containing all pertinent information for each thlete and their efforts.
class Olympian < ApplicationRecord
  validates_presence_of :name, :sex, :age, :team, :games, :sport, :event
end
