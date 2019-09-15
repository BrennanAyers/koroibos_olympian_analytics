class Athlete < ApplicationRecord
  validates_presence_of :name, :sex, :age, :team, :games, :sport, :event
end
