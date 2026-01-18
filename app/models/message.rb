class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user
  validates_presence_of :body, :conversation_id, :user_id

  # Αυτή η γραμμή κάνει το "μαγικό" της άμεσης εμφάνισης (Hotwire/Turbo)
  after_create_commit { broadcast_append_to self.conversation }
end