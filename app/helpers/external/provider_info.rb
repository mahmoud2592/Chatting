module External
  class ProviderInfo
    attr_accessor :uid, :email, :username, :date_format, :avatar, :provider
    attr_writer :birthday, :first_name, :last_name, :name

    def initialize
      yield self if block_given?
    end

    def first_name
      raw_name = @first_name

      if raw_name.present?
        raw_name
      elsif @name.present?
        split_name = @name.split(' ')
        if split_name.length > 1
          @name.split(' ')[0..-2].join(' ')
        else
          split_name.first
        end
      end
    end

    def last_name
      raw_name = @last_name

      if raw_name.present?
        raw_name
      elsif @name.present?
        split_name = @name.split(' ')
        return split_name if split_name.length > 1
      end
    end

    def birthday
      raw_value = @birthday

      if raw_value.is_a?(String)
        if date_format.present?
          Date.strptime raw_value, date_format
        else
          Date.parse raw_value
        end
      elsif raw_value.is_a?(Integer)
        Time.at(raw_value).to_date
      else
        raw_value
      end
    end

    def name
      raw_name = @name

      if raw_name.present?
        raw_name
      elsif @first_name.present? && @last_name.present?
        "#{@first_name} #{@last_name}"
      elsif @first_name.present?
        @first_name
      end
    end

    def to_h
      {
        uid: uid,
        email: email,
        username: username,
        birthday: birthday,
        first_name: first_name,
        last_name: last_name,
        name: name
      }
    end

    alias hash to_h
  end
end
