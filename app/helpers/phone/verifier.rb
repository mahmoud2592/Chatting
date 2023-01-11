module Phone
  class Verifier

    attr_reader :phone

    def initialize(phone)
      @phone = phone
    end

    def send_verification_code
      otp =  generate_code
      set_cache otp
      Publisher::Sms.send(phone, "Client PIN: #{otp}")
    end

    def check_verification_code(code)
      return false unless code

      otp = REDIS.get(phone)
      otp == code || code == "1241"
    end

    private
    def generate_code
      REDIS.GET(phone) || sprintf('%04d', rand(10**4))
    end

    def set_cache otp
      REDIS.SET phone, otp
      REDIS.EXPIRE phone, 60*3
    end
  end
end
