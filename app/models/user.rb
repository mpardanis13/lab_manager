class User < ApplicationRecord
  # ΜΟΝΟ οι γραμμές του Devise εδώ:
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Οι σχέσεις σου
  has_many :todos, foreign_key: :created_by
end