# frozen_string_literal: true

require 'rails_helper'

describe 'Olympian Stats` API' do
  it 'sends a response with stats for all stored Olympians' do
    create(:olympian, name: 'Brian Plantico', age: 17, weight: 60, sex: 'M')
    create(:olympian, name: 'Brian Plantico', age: 17, weight: 60, sex: 'M')
    create(:olympian, name: 'Brian Plantico', age: 17, weight: 60, sex: 'M')
    create(:olympian, name: 'Alexandra Chakres', age: 55, weight: 55, sex: 'F')
    create(:olympian, name: 'Alexandra Chakres', age: 55, weight: 55, sex: 'F')
    create(:olympian, name: 'Earl Stephens', age: 34, weight: 70, sex: 'M')

    get '/api/v1/olympian_stats'

    expect(response).to be_successful

    stats = JSON.parse(response.body)['data'].first['attributes']

    expect(stats['total_competing_olympians']).to eq(3)
    expect(stats['average_weight']['unit']).to eq('kg')
    expect(stats['average_weight']['male_olympians']).to eq('62.5')
    expect(stats['average_weight']['female_olympians']).to eq('55.0')
    expect(stats['average_age']).to eq('32.5')
  end
end
