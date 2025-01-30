class JsonWebToken
    # Secret key used for signing and verifying JWT
    SECRET_KEY = Rails.application.secret_key_base.to_s
  
    # Method to encode the payload and generate a token
    def self.encode(payload, exp = 24.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, SECRET_KEY)
    end
  
    # Method to decode the token and verify its authenticity
    def self.decode(token)
      body = JWT.decode(token, SECRET_KEY)[0]
      HashWithIndifferentAccess.new(body)
    rescue JWT::DecodeError
      nil
    end
  end
  