class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :friendships
  has_many :friends, through: :friendships, source: :friend
  has_many :todos, foreign_key: :created_by

  has_many :conversations, foreign_key: :sender_id
  validates_presence_of :name
end