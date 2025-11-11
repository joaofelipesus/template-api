require 'rails_helper'

RSpec.describe StudentSerializer do
  describe 'serialization' do
    let(:white_belt) { create(:belt, :white) }
    let(:student) { create(:student, name: 'John Doe', age: 25) }

    before do
      create(:graduation, student: student, belt: white_belt)
      create_list(:presence, 2, student: student, current_belt: white_belt)
    end

    context 'without associations' do
      let(:serializer) { StudentSerializer.new(student) }
      let(:serialization) { serializer.serializable_hash }

      it 'includes the correct attributes' do
        data = serialization[:data]

        expect(data[:id]).to eq(student.id.to_s)
        expect(data[:type]).to eq(:student)
        expect(data[:attributes][:name]).to eq('John Doe')
        expect(data[:attributes][:age]).to eq(25)
      end
    end

    context 'with associations' do
      let(:serializer) { StudentSerializer.new(student, include: [:presences, :graduations]) }
      let(:serialization) { serializer.serializable_hash }

      it 'includes presences relationship' do
        expect(serialization[:data][:relationships][:presences]).to be_present
        expect(serialization[:data][:relationships][:presences][:data].length).to eq(2)
      end

      it 'includes graduations relationship' do
        expect(serialization[:data][:relationships][:graduations]).to be_present
        expect(serialization[:data][:relationships][:graduations][:data].length).to eq(1)
      end
    end
  end
end
