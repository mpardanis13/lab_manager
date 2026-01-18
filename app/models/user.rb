class User < ApplicationRecord
  # Μόνο οι ρυθμίσεις του Devise
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Σχέσεις
  has_many :posts, dependent: :destroy
  has_many :todos, foreign_key: :created_by

end