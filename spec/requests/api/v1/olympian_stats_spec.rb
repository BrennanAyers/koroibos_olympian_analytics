require 'rails_helper'

describe 'Olympian Stats` API' do
  it 'sends a response with stats for all stored Olympians' do
    create(:olympian, name: 'Brian Plantico', age: 17, weight: 60)
    create(:olympian, name: 'Brian Plantico', age: 17, weight: 60)
    create(:olympian, name: 'Brian Plantico', age: 17, weight: 60)
    create(:olympian, name: 'Alexandra Chakres', age: 55, weight: 55)
    create(:olympian, name: 'Alexandra Chakres', age: 55, weight: 55)
    create(:olympian, name: 'Earl Stephens', age: 34, weight: 70)

    get "/api/v1/olympian_stats"

    expect(response).to be_successful

    stats = JSON.parse(response.body)['data'].first['attributes']

    expect(stats['total_competing_olympians']).to eq(3)
    expect(stats['average_weight']['unit']).to eq('kg')
    expect(stats['average_weight']['male_olympians']).to eq(65.0)
    expect(stats['average_weight']['female_olympians']).to eq(55.0)
    expect(stats['average_age']).to eq(35.3)
  end
end
