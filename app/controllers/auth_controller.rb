class AuthController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create]

  def create
    user = User.find_by(email: params[:email])

    if user&.valid_password?(params[:password])
      token = encode_token(user.id)
      render json: {
        data: {
          type: 'auth',
          attributes: {
            token: token,
            email: user.email
          }
        }
      }, status: :ok
    else
      render json: {
        errors: [{
          status: '401',
          title: 'Unauthorized',
          detail: 'Invalid email or password'
        }]
      }, status: :unauthorized
    end
  end

  private

  def encode_token(user_id)
    payload = { user_id: user_id, exp: 1.day.from_now.to_i }
    JWT.encode(payload, 'token', 'HS256')
  end
end
