class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    # Εμφάνιση όλων των συνομιλιών του χρήστη
    @conversations = Conversation.where("sender_id = ? OR recipient_id = ?", current_user.id, current_user.id)
  end

  def create
    # Αν υπάρχει ήδη συνομιλία την ανοίγουμε, αλλιώς τη δημιουργούμε
    if Conversation.between(params[:sender_id], params[:recipient_id]).present?
      @conversation = Conversation.between(params[:sender_id], params[:recipient_id]).first
    else
      @conversation = Conversation.create!(conversation_params)
    end
    redirect_to conversation_messages_path(@conversation)
  end

  private
  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end
end