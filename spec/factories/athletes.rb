# frozen_string_literal: true

FactoryBot.define do
  factory :athlete do
    name { 'MyName' }
    sex { 'GenderIsAConstruct' }
    age { 25 }
    height { 175 }
    weight { 70 }
    team { 'Teamy McTeamface' }
    games { 'PlayNo' }
    sport { 'Sportball' }
    event { 'Cookout' }
    medal { nil }
  end
end
