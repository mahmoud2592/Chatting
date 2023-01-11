module External
  module Provider
    class Google < Base
      def info
        ProviderInfo.new do |i|
          i.provider = External::Provider::Google.name
          i.avatar = raw_info[:picture]
          i.first_name = raw_info[:given_name]
          i.last_name = raw_info[:family_name]
          i.email = raw_info[:email]
          i.name = raw_info[:name]
          i.uid = raw_info[:sub]
        end
      end

      def retrieve_client
        GoogleIDToken::Validator.new
      end

      def retrieve_user_info
        client.check(id_token, client_ids)
      end

      def self.name
        :google
      end

      def client_ids
        [ENV["GOOGLE_IOS_CLIENT_ID"], ENV["GOOGLE_ANDROID_CLIENT_ID"]]
      end

      private

      alias id_token access_token
    end
  end
end
