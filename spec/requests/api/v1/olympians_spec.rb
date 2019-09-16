# frozen_string_literal: true

require 'rails_helper'

describe 'Olympian API' do
  it 'sends a list of olympians' do
    create_list(:olympian, 3)

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

    expect(olympians.count).to eq(2)
    expect(olympians.first.name).to eq('Brian Plantico')
    expect(olympians.first.team).to eq('Wisconsin')
    expect(olympians.first.age).to eq(17)
    expect(olympians.first.sport).to eq('Cycling')
    expect(olympians.first.total_medals_won).to eq(1)
    expect(olympians.last.name).to eq('Logan Pile')
    expect(olympians.last.team).to eq('Colorado')
    expect(olympians.last.age).to eq(55)
    expect(olympians.last.sport).to eq('Wakeboarding')
    expect(olympians.last.total_medals_won).to eq(0)
  end
end
