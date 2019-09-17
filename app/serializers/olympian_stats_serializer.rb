# frozen_string_literal: true

# A FastJSON API Serializer to take in an Olympian Stats object and
# return only the required attributes
class OlympianStatsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :total_competing_olympians

  attribute :average_age do |object|
    object.average_age.round(1)
  end

  attribute :average_weight do |object|
    {
      unit: 'kg',
      male_olympians: object.male_olympians.round(1),
      female_olympians: object.female_olympians.round(1)
    }
  end
end
