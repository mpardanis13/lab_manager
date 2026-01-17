class JsonWebToken
  # Το μυστικό κλειδί της εφαρμογής σου για να υπογράφει τα tokens
  SECRET_KEY = Rails.application.secret_key_base

  # Φτιάχνει ένα νέο token
  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  # Διαβάζει ένα υπάρχον token
  def self.decode(token)
    body = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new body
  rescue
    nil # Αν το token είναι λάθος, επέστρεψε τίποτα
  end
end