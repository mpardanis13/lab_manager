class User < ApplicationRecord
  # Μόνο οι ρυθμίσεις του Devise
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :friendships
  # Λέμε στη Rails: "Οι friends είναι Users και θα τους βρεις μέσω του friendship.friend"
  has_many :friends, through: :friendships, source: :friend

  has_many :posts, dependent: :destroy
  has_many :todos, foreign_key: :created_by
end