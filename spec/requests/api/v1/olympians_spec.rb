# frozen_string_literal: true

require 'rails_helper'

describe 'Olympian API' do
  it 'sends a list of olympians' do
    create(:olympian, name: 'Brian Plantico', team: 'Wisconsin', age: 17, sport: 'Cycling', medal: 'Gold')
    create(:olympian, name: 'Earl Stephens', team: 'Florida', age: 34, sport: 'Boxing', event: 'VS Mike Tyson')
    create(:olympian, name: 'Logan Pile', team: 'Colorado', age: 55, sport: 'Wakeboarding', event: 'Sick Waves')

    get '/api/v1/olympians'

    expect(response).to be_successful

    olympians = JSON.parse(response.body)['data']

    expect(olympians.count).to eq(3)
  end

  it 'sends a list of olympians serialized correctly' do
    create(:olympian, name: 'Brian Plantico', team: 'Wisconsin', age: 17, sport: 'Cycling', medal: 'Gold')
    create(:olympian, name: 'Brian Plantico', team: 'Wisconsin', age: 17, sport: 'Cycling', event: 'The Downhill')
    create(:olympian, name: 'Logan Pile', team: 'Colorado', age: 55, sport: 'Wakeboarding', event: 'Sick Waves')

    get '/api/v1/olympians'

    expect(response).to be_successful

    olympians = JSON.parse(response.body)['data']

    expect(olympians.length).to eq(2)
    expect(olympians.first['attributes']['name']).to eq('Brian Plantico')
    expect(olympians.first['attributes']['team']).to eq('Wisconsin')
    expect(olympians.first['attributes']['age']).to eq(17)
    expect(olympians.first['attributes']['sport']).to eq('Cycling')
    expect(olympians.first['attributes']['total_medals_won']).to eq(1)
    expect(olympians.last['attributes']['name']).to eq('Logan Pile')
    expect(olympians.last['attributes']['team']).to eq('Colorado')
    expect(olympians.last['attributes']['age']).to eq(55)
    expect(olympians.last['attributes']['sport']).to eq('Wakeboarding')
    expect(olympians.last['attributes']['total_medals_won']).to eq(0)
  end

  it 'should return the youngest Olympian with pertinent information' do
    create(:olympian, name: 'Brian Plantico', team: 'Wisconsin', age: 17, sport: 'Cycling', medal: 'Gold')
    create(:olympian, name: 'Brian Plantico', team: 'Wisconsin', age: 17, sport: 'Cycling', medal: 'Silver')
    create(:olympian, name: 'Brian Plantico', team: 'Wisconsin', age: 17, sport: 'Cycling', event: 'The Downhill')
    create(:olympian, name: 'Logan Pile', team: 'Colorado', age: 55, sport: 'Wakeboarding', event: 'Sick Waves')
    create(:olympian, name: 'Logan Pile', team: 'Colorado', age: 55, sport: 'Wakeboarding', event: 'Not So Sick Waves')
    create(:olympian, name: 'Earl Stephens', team: 'Florida', age: 34, sport: 'Boxing', event: 'VS Mike Tyson')

    get '/api/v1/olympians?age=youngest'

    expect(response).to be_successful

    olympian = JSON.parse(response.body)['data']

    expect(olympian.length).to eq(1)
    expect(olympian.first['attributes']['name']).to eq('Brian Plantico')
    expect(olympian.first['attributes']['team']).to eq('Wisconsin')
    expect(olympian.first['attributes']['age']).to eq(17)
    expect(olympian.first['attributes']['sport']).to eq('Cycling')
    expect(olympian.first['attributes']['total_medals_won']).to eq(2)
  end

  it 'should return the oldest Olympian with pertinent information' do
    create(:olympian, name: 'Brian Plantico', team: 'Wisconsin', age: 17, sport: 'Cycling', medal: 'Gold')
    create(:olympian, name: 'Brian Plantico', team: 'Wisconsin', age: 17, sport: 'Cycling', medal: 'Silver')
    create(:olympian, name: 'Brian Plantico', team: 'Wisconsin', age: 17, sport: 'Cycling', event: 'The Downhill')
    create(:olympian, name: 'Logan Pile', team: 'Colorado', age: 55, sport: 'Wakeboarding', event: 'Sick Waves')
    create(:olympian, name: 'Logan Pile', team: 'Colorado', age: 55, sport: 'Wakeboarding', event: 'Not So Sick Waves')
    create(:olympian, name: 'Earl Stephens', team: 'Florida', age: 34, sport: 'Boxing', event: 'VS Mike Tyson')

    get '/api/v1/olympians?age=oldest'

    expect(response).to be_successful

    olympian = JSON.parse(response.body)['data']

    expect(olympian.length).to eq(1)
    expect(olympian.first['attributes']['name']).to eq('Logan Pile')
    expect(olympian.first['attributes']['team']).to eq('Colorado')
    expect(olympian.first['attributes']['age']).to eq(55)
    expect(olympian.first['attributes']['sport']).to eq('Wakeboarding')
    expect(olympian.first['attributes']['total_medals_won']).to eq(0)
  end
end
