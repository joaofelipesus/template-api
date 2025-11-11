require 'rails_helper'

RSpec.describe StudentsController, type: :request do
  describe 'GET /students' do
    it 'returns all students' do
      students = create_list(:student, 3)

      get '/students'

      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response['data'].length).to eq(3)
    end
  end

  describe 'GET /students/:id' do
    let(:white_belt) { create(:belt, :white) }
    let(:student) { create(:student) }

    before do
      create(:graduation, student: student, belt: white_belt)
      create_list(:presence, 2, student: student, current_belt: white_belt)
    end

    it 'returns the student with presences and graduations' do
      get "/students/#{student.id}"

      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response['data']['id']).to eq(student.id.to_s)
      expect(json_response['data']['attributes']['name']).to eq(student.name)
      expect(json_response['data']['attributes']['age']).to eq(student.age)
    end
  end

  describe 'POST /students' do
    let(:white_belt) { create(:belt, :white) }

    before { white_belt }

    context 'with valid parameters' do
      let(:valid_params) do
        { student: { name: 'John Doe', age: 25 } }
      end

      it 'creates a new student' do
        expect {
          post '/students', params: valid_params
        }.to change(Student, :count).by(1)
      end

      it 'creates a graduation with white belt' do
        expect {
          post '/students', params: valid_params
        }.to change(Graduation, :count).by(1)
      end

      it 'returns created status' do
        post '/students', params: valid_params
        expect(response).to have_http_status(:created)
      end

      it 'returns the created student' do
        post '/students', params: valid_params
        json_response = JSON.parse(response.body)
        expect(json_response['data']['attributes']['name']).to eq('John Doe')
        expect(json_response['data']['attributes']['age']).to eq(25)
      end
    end

    context 'with valid parameters' do\
      let(:invalid_params) { { student: { age: 25 } } }

      it 'creates a new student' do
        expect {
          post '/students', params: invalid_params
        }.not_to change(Student, :count)
      end

      it 'returns created status' do
        post '/students', params: invalid_params

        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe 'PATCH /students/:id' do
    let(:student) { create(:student, name: 'Old Name', age: 20) }

    context 'with valid parameters' do
      let(:valid_params) do
        { student: { name: 'New Name', age: 30 } }
      end

      it 'updates the student' do
        patch "/students/#{student.id}", params: valid_params
        student.reload
        expect(student.name).to eq('New Name')
        expect(student.age).to eq(30)
      end

      it 'returns ok status' do
        patch "/students/#{student.id}", params: valid_params
        expect(response).to have_http_status(:ok)
      end

      it 'returns the updated student' do
        patch "/students/#{student.id}", params: valid_params
        json_response = JSON.parse(response.body)
        expect(json_response['data']['attributes']['name']).to eq('New Name')
        expect(json_response['data']['attributes']['age']).to eq(30)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        { student: { name: '', age: nil } }
      end

      it 'does not update the student' do
        patch "/students/#{student.id}", params: invalid_params
        student.reload
        expect(student.name).to eq('Old Name')
        expect(student.age).to eq(20)
      end

      it 'returns unprocessable_entity status' do
        patch "/students/#{student.id}", params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns error messages' do
        patch "/students/#{student.id}", params: invalid_params
        json_response = JSON.parse(response.body)
        expect(json_response['errors']).to be_present
      end
    end
  end
end
