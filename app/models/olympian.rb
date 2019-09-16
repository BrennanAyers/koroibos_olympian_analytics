# frozen_string_literal: true

# The Olympian model is the main form of data storage in the app,
# containing all pertinent information for each thlete and their efforts.
class Olympian < ApplicationRecord
  validates_presence_of :name, :sex, :age, :team, :games, :sport, :event

  def self.all_with_total_medals_won
    select(
      'olympians.name,
      olympians.team,
      olympians.age,
      olympians.sport,
      COUNT (medal) AS total_medals_won'
    )
      .group(:name, :team, :age, :sport)
      .order(:name)
  end
end
