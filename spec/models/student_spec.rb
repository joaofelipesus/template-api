require 'rails_helper'

RSpec.describe Student, type: :model do
  describe 'associations' do
    it 'has many presences' do
      student = create(:student)
      belt = create(:belt)
      presence = create(:presence, student: student, current_belt: belt)
      expect(student.presences).to include(presence)
    end

    it 'has many graduations' do
      student = create(:student)
      belt = create(:belt)
      graduation = create(:graduation, student: student, belt: belt)
      expect(student.graduations).to include(graduation)
    end
  end

  describe 'validations' do
    it 'validates presence of name' do
      student = Student.new(age: 25)
      expect(student).not_to be_valid
      expect(student.errors[:name]).to be_present
    end

    it 'validates presence of age' do
      student = Student.new(name: 'Test')
      expect(student).not_to be_valid
      expect(student.errors[:age]).to be_present
    end
  end

  describe '#belt' do
    it 'returns the most recent belt from graduations' do
      student = create(:student)
      white_belt = create(:belt, :white)
      yellow_belt = create(:belt, :yellow)

      create(:graduation, student: student, belt: white_belt, created_at: 1.day.ago)
      create(:graduation, student: student, belt: yellow_belt, created_at: Time.current)

      expect(student.belt).to eq(yellow_belt)
    end
  end

  describe '#add_presence' do
    let(:white_belt) { create(:belt, :white) }
    let(:yellow_belt) { create(:belt, :yellow) }
    let(:student) { create(:student) }

    before do
      create(:graduation, student: student, belt: white_belt)
    end

    context 'when student has not reached required presences' do
      it 'creates a presence' do
        expect { student.add_presence }.to change(Presence, :count).by(1)
      end

      it 'sets the current_belt_id to the student belt' do
        presence = student.add_presence
        expect(presence.current_belt_id).to eq(white_belt.id)
      end
    end

    context 'when student has reached required presences for graduation' do
      before do
        yellow_belt
        white_belt.update!(presences_required: 2)
        create(:presence, student: student, current_belt: white_belt)
      end

      it 'creates a new graduation' do
        # Define current_graduation method that returns an object with next method
        graduation_proxy = Struct.new(:next).new(yellow_belt)
        student.define_singleton_method(:current_graduation) { graduation_proxy }
        expect { student.add_presence }.to change(Graduation, :count).by(1)
      end

      it 'creates a presence' do
        # Define current_graduation method that returns an object with next method
        graduation_proxy = Struct.new(:next).new(yellow_belt)
        student.define_singleton_method(:current_graduation) { graduation_proxy }
        expect { student.add_presence }.to change(Presence, :count).by(1)
      end
    end

    context 'when student has black belt' do
      let(:black_belt) { create(:belt, :black) }

      before do
        student.graduations.destroy_all
        create(:graduation, student: student, belt: black_belt)
      end

      it 'creates a presence' do
        expect { student.add_presence }.to change(Presence, :count).by(1)
      end

      it 'does not create a new graduation' do
        expect { student.add_presence }.not_to change(Graduation, :count)
      end

      it 'returns nil' do
        expect(student.add_presence).to be_nil
      end
    end
  end

  describe '.create_new_student!' do
    let(:white_belt) { create(:belt, :white) }

    before { white_belt }

    it 'creates a student' do
      expect {
        Student.create_new_student!(name: 'John Doe', age: 25)
      }.to change(Student, :count).by(1)
    end

    it 'creates a graduation with white belt' do
      expect {
        Student.create_new_student!(name: 'John Doe', age: 25)
      }.to change(Graduation, :count).by(1)
    end

    it 'returns the created student' do
      student = Student.create_new_student!(name: 'John Doe', age: 25)
      expect(student).to be_a(Student)
      expect(student.name).to eq('John Doe')
      expect(student.age).to eq(25)
    end

    it 'assigns white belt to the student' do
      student = Student.create_new_student!(name: 'John Doe', age: 25)
      expect(student.belt).to eq(white_belt)
    end
  end

  describe '#current_belt_presences_count' do
    let(:belt) { create(:belt) }
    let(:student) { create(:student) }

    before do
      create(:graduation, student: student, belt: belt)
    end

    it 'returns the count of presences for the current belt' do
      create_list(:presence, 3, student: student, current_belt: belt)
      expect(student.current_belt_presences_count).to eq(3)
    end

    it 'does not count presences from other belts' do
      other_belt = create(:belt)
      create_list(:presence, 2, student: student, current_belt: belt)
      create(:presence, student: student, current_belt: other_belt)

      expect(student.current_belt_presences_count).to eq(2)
    end
  end
end
