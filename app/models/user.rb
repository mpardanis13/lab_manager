class User < ApplicationRecord
  # Αυτή η γραμμή ενεργοποιεί την κρυπτογράφηση κωδικού
  has_secure_password

  # Σχέσεις: Ένας χρήστης έχει πολλά todos
  has_many :todos, foreign_key: :created_by
  
  # Έλεγχοι: Πρέπει να υπάρχουν πάντα αυτά τα πεδία
  validates_presence_of :name, :email, :password_digest
  validates_uniqueness_of :email
end