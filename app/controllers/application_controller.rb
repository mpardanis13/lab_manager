class ApplicationController < ActionController::API
  before_action :authorize_request
  attr_reader :current_user

  private

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    decoded = JsonWebToken.decode(header)
    
    if decoded
      @current_user = User.find(decoded[:user_id])
    else
      render json: { error: 'Not Authorized' }, status: :unauthorized
    end
  end
end