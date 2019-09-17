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
      create(:olympian, name: 'Brian Plantico', sex: 'M', team: 'Wisconsin', age: 17, weight: 70, sport: 'Cycling', medal: 'Gold')
      create(:olympian, name: 'Brian Plantico', sex: 'M', team: 'Wisconsin', age: 17, weight: 70, sport: 'Cycling', medal: 'Silver')
      create(:olympian, name: 'Brian Plantico', sex: 'M', team: 'Wisconsin', age: 17, weight: 70, sport: 'Cycling', event: 'The Downhill')
      create(:olympian, name: 'Logan Pile', sex: 'M', team: 'Colorado', age: 55, weight: 60, sport: 'Wakeboarding', event: 'Sick Waves')
      create(:olympian, name: 'Logan Pile', sex: 'M', team: 'Colorado', age: 55, weight: 60, sport: 'Wakeboarding', event: 'Not So Sick Waves')
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

    it "should return the oldest Olympian with ::all_with_total_medals_won('DESC')" do
      expect(Olympian.all.length).to eq(5)
      oldest = Olympian.all_with_total_medals_won('DESC')
      expect(oldest.length).to eq(1)
      expect(oldest.first.name).to_not eq('Brian Plantico')
      expect(oldest.last.name).to eq('Logan Pile')
      expect(oldest.first.total_medals_won).to_not eq(2)
      expect(oldest.last.total_medals_won).to eq(0)
    end

    it 'should return the statistics for all Olympians in the database with ::statistics' do
      create(:olympian, name: 'Alexandra Chakres', sex: 'F', age: 34, weight: 55)
      expect(Olympian.all.length).to eq(6)
      stats = Olympian.statistics.take
      expect(stats.total_competing_olympians).to eq(3)
      expect(stats.male_olympians).to eq(66.0)
      expect(stats.female_olympians).to eq(55.0)
      expect(stats.average_age).to eq(32.5)
    end
  end
end
