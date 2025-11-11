require 'rails_helper'

RSpec.describe BeltSerializer do
  describe 'serialization' do
    let(:belt) { create(:belt, name: 'White', presences_required: 10) }
    let(:serializer) { BeltSerializer.new(belt) }
    let(:serialization) { serializer.serializable_hash }

    it 'includes the correct attributes' do
      data = serialization[:data]

      expect(data[:id]).to eq(belt.id.to_s)
      expect(data[:type]).to eq(:belt)
      expect(data[:attributes][:name]).to eq('White')
      expect(data[:attributes][:presences_required]).to eq(10)
    end
  end
end
