class User < ApplicationRecord
  # Προσθέτουμε το :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2, :facebook]

  has_many :posts, dependent: :destroy
  has_many :friendships
  has_many :friends, through: :friendships, source: :friend
  has_many :todos, foreign_key: :created_by
  has_many :conversations, foreign_key: :sender_id

  # Μέθοδος για τη δημιουργία χρήστη από Omniauth
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name   # Παίρνει το όνομα από το προφίλ της Google/FB
    end
  end
end