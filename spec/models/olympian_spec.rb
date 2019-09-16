# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Olympian, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :sex }
    it { should validate_presence_of :age }
    # it { should validate_presence_of :height }
    # it { should validate_presence_of :weight }
    it { should validate_presence_of :team }
    it { should validate_presence_of :games }
    it { should validate_presence_of :sport }
    it { should validate_presence_of :event }
    it { should_not validate_presence_of :medal }
  end

  describe 'class methods' do
    before :each do
      create(:olympian, name: 'Brian Plantico', team: 'Wisconsin', age: 17, sport: 'Cycling', medal: 'Gold')
      create(:olympian, name: 'Brian Plantico', team: 'Wisconsin', age: 17, sport: 'Cycling', medal: 'Silver')
      create(:olympian, name: 'Brian Plantico', team: 'Wisconsin', age: 17, sport: 'Cycling', event: 'The Downhill')
      create(:olympian, name: 'Logan Pile', team: 'Colorado', age: 55, sport: 'Wakeboarding', event: 'Sick Waves')
      create(:olympian, name: 'Logan Pile', team: 'Colorado', age: 55, sport: 'Wakeboarding', event: 'Not So Sick Waves')
    end

    it 'should return collated Olympians with ::all_with_total_medals_won' do
      expect(Olympian.all.length).to eq(5)
      olympians = Olympian.all_with_total_medals_won
      expect(olympians.length).to eq(2)
      expect(olympians.first.name).to eq('Brian Plantico')
      expect(olympians.last.name).to eq('Logan Pile')
      expect(olympians.first.total_medals_won).to eq(2)
      expect(olympians.last.total_medals_won).to eq(0)
    end

    it "should return the youngest Olympian with ::all_with_total_medals_won('ASC')" do
      expect(Olympian.all.length).to eq(5)
      youngest = Olympian.all_with_total_medals_won('ASC')
      expect(youngest.length).to eq(1)
      expect(youngest.first.name).to eq('Brian Plantico')
      expect(youngest.last.name).to_not eq('Logan Pile')
      expect(youngest.first.total_medals_won).to eq(2)
      expect(youngest.last.total_medals_won).to_not eq(0)
    end
  end
end
