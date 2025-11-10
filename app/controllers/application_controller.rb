class ApplicationController < ActionController::API
  before_action :authenticate_user!

  private

  def authenticate_user!
    return if skip_authentication?

    header = request.headers['Authorization']
    token = header.split(' ').last if header

    begin
      decoded = JWT.decode(token, 'token', true, algorithm: 'HS256')
      @current_user = User.find(decoded[0]['user_id'])
    rescue ActiveRecord::RecordNotFound, JWT::DecodeError
      render json: {
        errors: [{
          status: '401',
          title: 'Unauthorized',
          detail: 'Invalid or missing token'
        }]
      }, status: :unauthorized
    end
  end

  def current_user
    @current_user
  end

  def skip_authentication?
    false
  end
end
