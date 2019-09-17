# frozen_string_literal: true

# The Olympian model is the main form of data storage in the app,
# containing all pertinent information for each thlete and their efforts.
class Olympian < ApplicationRecord
  validates_presence_of :name, :sex, :age, :team, :games, :sport, :event

  def self.all_with_total_medals_won(age = nil)
    olympians = select(
      'olympians.name,
      olympians.team,
      olympians.age,
      olympians.sport,
      COUNT (medal) AS total_medals_won'
    )
      .group(:name, :team, :age, :sport)
      .order(:name)
    !age.nil? ? olympians.unscope(:order).order(age: age).limit(1) : olympians
  end

  def self.statistics
    select("COUNT (DISTINCT name) AS total_competing_olympians,
    AVG (age) AS average_age,
    AVG (CASE WHEN sex = 'M' THEN weight END) AS male_olympians,
    AVG (CASE WHEN sex = 'F' THEN weight END) AS female_olympians")
  end
end
