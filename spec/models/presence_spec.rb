require 'rails_helper'

RSpec.describe Presence, type: :model do
  describe 'associations' do
    it 'belongs to student' do
      student = create(:student)
      belt = create(:belt)
      presence = create(:presence, student: student, current_belt: belt)
      expect(presence.student).to eq(student)
    end

    it 'belongs to current_belt' do
      student = create(:student)
      belt = create(:belt)
      presence = create(:presence, student: student, current_belt: belt)
      expect(presence.current_belt).to eq(belt)
    end
  end
end
