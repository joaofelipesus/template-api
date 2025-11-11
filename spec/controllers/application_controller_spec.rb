require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
    def index
      render plain: 'OK'
    end
  end

  describe 'GET index' do
    it 'renders successfully' do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end
end
