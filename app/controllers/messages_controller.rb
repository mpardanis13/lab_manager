class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conversation

  def index
    # Εμφανίζουμε μόνο τα αποθηκευμένα μηνύματα
    @messages = @conversation.messages.where.not(id: nil)
    @message = Message.new
  end

  def create
    @message = @conversation.messages.new(message_params)
    @message.user = current_user

    if @message.save
      respond_to do |format|
        format.turbo_stream do
          # Εμφανίζουμε το μήνυμα στον εαυτό μας (δεξιά/μπλε)
          render turbo_stream: turbo_stream.append("messages", partial: "messages/message", locals: { message: @message, mine: true })
        end
        format.html { redirect_to conversation_messages_path(@conversation) }
      end
    end
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end

  def message_params
    params.require(:message).permit(:body)
  end
end