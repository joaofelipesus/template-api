require 'rails_helper'

RSpec.describe GraduationSerializer do
  describe 'serialization' do
    let(:belt) { create(:belt, name: 'White') }
    let(:student) { create(:student) }
    let(:graduation) { create(:graduation, student: student, belt: belt) }

    context 'without associations' do
      let(:serializer) { GraduationSerializer.new(graduation) }
      let(:serialization) { serializer.serializable_hash }

      it 'includes the correct attributes' do
        data = serialization[:data]

        expect(data[:id]).to eq(graduation.id.to_s)
        expect(data[:type]).to eq(:graduation)
        expect(data[:attributes][:created_at]).to be_present
        expect(data[:attributes][:updated_at]).to be_present
        expect(data[:attributes][:belt_name]).to eq('White')
      end
    end

    context 'with associations' do
      let(:serializer) { GraduationSerializer.new(graduation, include: [:student, :belt]) }
      let(:serialization) { serializer.serializable_hash }

      it 'includes student relationship' do
        expect(serialization[:data][:relationships][:student]).to be_present
        expect(serialization[:data][:relationships][:student][:data][:id]).to eq(student.id.to_s)
      end

      it 'includes belt relationship' do
        expect(serialization[:data][:relationships][:belt]).to be_present
        expect(serialization[:data][:relationships][:belt][:data][:id]).to eq(belt.id.to_s)
      end
    end
  end
end
