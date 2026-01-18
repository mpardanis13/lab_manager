class ApplicationController < ActionController::Base
  # Επιτρέπουμε στο Devise να δουλεύει κανονικά
  protect_from_forgery with: :exception
  
  # Το authorize_request τρέχει ΜΟΝΟ για το API (JSON)
  before_action :authorize_request, if: -> { request.format.json? }

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