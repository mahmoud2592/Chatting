# frozen_string_literal: true
module Publisher
  class Sms

    class << self
      require 'twilio-ruby'

      def send(phone, content)

        account_sid = "" # Your Test Account SID from www.twilio.com/console/settings
        auth_token = ""   # Your Test Auth Token from www.twilio.com/console/settings

        @client = Twilio::REST::Client.new account_sid, auth_token
        message = @client.messages.create(
            body: content,
            to: phone,    # Replace with your phone number
            from: "+15005550006")  # Use this Magic Number for creating SMS

        puts message.sid
      rescue StandardError
        false
      end
    end
  end
end
