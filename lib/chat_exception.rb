module ChatException
  class UnAuthenticated < StandardError
    def message
      "no authintication was provided"
    end
  end

  class UnConfirmedUser < StandardError
    def message
      "this account is not confirmed, please confirm your account"
    end
  end

  class MissingToken < StandardError
    def message
      "missing access token"
    end
  end

  class InvalidToken < StandardError
    def message
      "invalid token"
    end
  end

  class ExpiredToken < StandardError
    def message
      "token expired"
    end
  end

  class DecodingError < StandardError
  end

  class InvalidCredentials < StandardError
    def message
      "Phone or Password is incorrect"
    end
  end
  class InvalidPassword < StandardError
    def message
      "Password is incorrect"
    end
  end
end
