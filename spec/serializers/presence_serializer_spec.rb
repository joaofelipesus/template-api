require 'rails_helper'

RSpec.describe PresenceSerializer do
  describe 'serialization' do
    let(:belt) { create(:belt, :white) }
    let(:student) { create(:student) }
    let(:presence) { create(:presence, student: student, current_belt: belt) }

    before do
      create(:graduation, student: student, belt: belt)
      create_list(:presence, 2, student: student, current_belt: belt)
    end

    context 'without associations' do
      let(:serializer) { PresenceSerializer.new(presence) }
      let(:serialization) { serializer.serializable_hash }

      it 'includes the correct attributes' do
        data = serialization[:data]

        expect(data[:id]).to eq(presence.id.to_s)
        expect(data[:type]).to eq(:presence)
        expect(data[:attributes][:created_at]).to be_present
        expect(data[:attributes][:progress]).to eq(3)
      end
    end

    context 'with associations' do
      let(:serializer) { PresenceSerializer.new(presence, include: [:student, :current_belt]) }
      let(:serialization) { serializer.serializable_hash }

      it 'includes student relationship' do
        expect(serialization[:data][:relationships][:student]).to be_present
        expect(serialization[:data][:relationships][:student][:data][:id]).to eq(student.id.to_s)
      end

      it 'includes current_belt relationship' do
        expect(serialization[:data][:relationships][:current_belt]).to be_present
        expect(serialization[:data][:relationships][:current_belt][:data][:id]).to eq(belt.id.to_s)
      end
    end
  end
end
