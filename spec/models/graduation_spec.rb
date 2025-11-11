require 'rails_helper'

RSpec.describe Graduation, type: :model do
  describe 'associations' do
    it 'belongs to student' do
      student = create(:student)
      belt = create(:belt)
      graduation = create(:graduation, student: student, belt: belt)
      expect(graduation.student).to eq(student)
    end

    it 'belongs to belt' do
      student = create(:student)
      belt = create(:belt)
      graduation = create(:graduation, student: student, belt: belt)
      expect(graduation.belt).to eq(belt)
    end
  end
end
