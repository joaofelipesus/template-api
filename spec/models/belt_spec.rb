require 'rails_helper'

RSpec.describe Belt, type: :model do
  describe 'associations' do
    it 'has many graduations' do
      belt = create(:belt)
      graduation = create(:graduation, belt: belt)
      expect(belt.graduations).to include(graduation)
    end

    it 'has many presences with current_belt_id foreign key' do
      belt = create(:belt)
      student = create(:student)
      presence = create(:presence, current_belt: belt, student: student)
      expect(belt.presences).to include(presence)
    end
  end

  describe 'validations' do
    it 'validates presence of name' do
      belt = Belt.new(presences_required: 10)
      expect(belt).not_to be_valid
      expect(belt.errors[:name]).to be_present
    end

    it 'validates presence of presences_required' do
      belt = Belt.new(name: 'Test')
      expect(belt).not_to be_valid
      expect(belt.errors[:presences_required]).to be_present
    end

    it 'validates uniqueness of name' do
      create(:belt, name: 'White')
      belt = Belt.new(name: 'White', presences_required: 10)
      expect(belt).not_to be_valid
      expect(belt.errors[:name]).to be_present
    end
  end

  describe '.white' do
    it 'returns the White belt' do
      white_belt = create(:belt, :white)
      expect(Belt.white).to eq(white_belt)
    end
  end

  describe '#black?' do
    context 'when belt is Black' do
      it 'returns true' do
        belt = create(:belt, :black)
        expect(belt.black?).to be true
      end
    end

    context 'when belt is not Black' do
      it 'returns false' do
        belt = create(:belt, :white)
        expect(belt.black?).to be false
      end
    end
  end

  describe '#next' do
    context 'when belt is not Black' do
      it 'returns the next belt in sequence' do
        white_belt = create(:belt, :white)
        yellow_belt = create(:belt, :yellow)

        expect(white_belt.next.first).to eq(yellow_belt)
      end
    end

    context 'when belt is Black' do
      it 'raises an error' do
        belt = create(:belt, :black)
        expect { belt.next }.to raise_error('Black belt is the last graduation')
      end
    end
  end
end
