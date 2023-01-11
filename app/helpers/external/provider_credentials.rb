module External
  class ProviderCredentials
    attr_accessor :access_token, :refresh_token, :expires, :expires_at

    def initialize
      yield self if block_given?
    end

    def to_h
      {
        access_token: access_token,
        refresh_token: refresh_token,
        expires: expires,
        expires_at: expires_at
      }
    end

    alias hash to_h
  end
end
