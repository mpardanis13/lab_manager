class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: [:authenticate, :signup]

  def signup
    user = User.create!(user_params)
    auth_token = JsonWebToken.encode(user_id: user.id)
    render json: { message: 'Account created', auth_token: auth_token }, status: :created
  end

  def authenticate
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      auth_token = JsonWebToken.encode(user_id: user.id)
      render json: { auth_token: auth_token }
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end

  private
  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end