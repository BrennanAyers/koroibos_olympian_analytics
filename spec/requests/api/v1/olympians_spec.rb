require 'rails_helper'

describe 'Olympian API' do
  it 'sends a list of olympians' do
    create_list(:olympian, 3)

    get "/api/v1/olympians"

    expect(response).to be_successful

    olympians = JSON.parse(response.body)['data']

    expect(olympians.count).to eq(3)
  end
end
