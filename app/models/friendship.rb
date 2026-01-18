class Friendship < ApplicationRecord
  belongs_to :user
  # Λέμε ότι ο friend είναι στην πραγματικότητα ένας User
  belongs_to :friend, class_name: "User"
end