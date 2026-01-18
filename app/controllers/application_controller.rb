class ApplicationController < ActionController::Base # Προσοχή: Εδώ βάλε Base αντί για API
  # Ζητάμε το Token μόνο αν το αίτημα είναι τύπου JSON (δηλαδή για το API)
  before_action :authorize_request, if: -> { request.format.json? }
  
  # Προστασία από CSRF (απαραίτητο για τις φόρμες του Portal)
  protect_from_forgery with: :null_session, if: -> { request.format.json? }

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