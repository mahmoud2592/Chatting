module Phone
  class Validator

    COUNTRIES = ['US']

    attr_reader :phone

    def initialize(phone)
      @phone = phone
    end

    def internationl_format
      return nil unless country
      Phonelib.parse(phone, country).international(false)
    end

    def valid?
      COUNTRIES.any? { |country| Phonelib.valid_for_country?(phone, country) }
    end

    def country
      @country || valid_country
    end

    private
    def valid_country
      COUNTRIES.each do |country|
        return country if valid = Phonelib.valid_for_country?(phone, country)
        valid
      end
      nil
    end
  end
end

