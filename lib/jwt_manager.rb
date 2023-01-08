require Rails.root.join('lib/Chat_exception')
class JWTManager
  class << self
    def encode(payload, exp = 2.hours.from_now)
      JWT.encode(payload, Rails.application.secrets.secret_key_base)
    end

    def decode(token)
      JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
      rescue JWT::ExpiredSignature
      raise ChatException::ExpiredToken
      rescue JWT::DecodeError => e
      raise ChatException::DecodingError, e.message
    end
  end
end
