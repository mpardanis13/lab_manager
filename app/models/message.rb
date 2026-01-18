class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user
  validates_presence_of :body, :conversation_id, :user_id

  # Εκπέμπουμε το μήνυμα ζωντανά στον recipient. 
  # Για τον παραλήπτη, το μήνυμα θα εμφανίζεται πάντα αριστερά (mine: false).
  after_create_commit { broadcast_append_to self.conversation, target: "messages", locals: { mine: false } }
end