# frozen_string_literal: true

# A FastJSON API Serializer to take in a collection of Olympian objects and
# return only the required attributes
class OlympianSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :team, :age, :sport, :total_medals_won
end
