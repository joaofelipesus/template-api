require 'rails_helper'

RSpec.describe PresencesController, type: :request do
  describe 'POST /presences' do
    let(:white_belt) { create(:belt, :white) }
    let(:yellow_belt) { create(:belt, :yellow) }
    let(:student) { create(:student) }

    before do
      create(:graduation, student: student, belt: white_belt)
    end

    context 'with valid parameters' do
      let(:valid_params) do
        { presence: { student_id: student.id } }
      end

      it 'creates a new presence' do
        expect {
          post '/presences', params: valid_params
        }.to change(Presence, :count).by(1)
      end

      it 'returns ok status' do
        post '/presences', params: valid_params
        expect(response).to have_http_status(:ok)
      end

      it 'returns the created presence with current_belt' do
        post '/presences', params: valid_params
        json_response = JSON.parse(response.body)
        expect(json_response['data']['type']).to eq('presence')
        expect(json_response['data']['attributes']).to have_key('created_at')
      end
    end

    context 'when student has black belt' do
      let(:black_belt) { create(:belt, :black) }

      before do
        student.graduations.destroy_all
        create(:graduation, student: student, belt: black_belt)
      end

      let(:valid_params) do
        { presence: { student_id: student.id } }
      end

      it 'returns unprocessable_entity status' do
        post '/presences', params: valid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns error message' do
        post '/presences', params: valid_params
        json_response = JSON.parse(response.body)
        expect(json_response['errors']).to be_present
        expect(json_response['errors'].first['title']).to eq('cant create presence try again later')
      end
    end
  end
end
