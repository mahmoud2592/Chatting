module External
  # A base class for handling external logins
  module Provider
    class Base
      attr_reader :access_token, :refresh_token, :client

      def initialize(access_token, refresh_token = nil)
        handle_missing_access_token unless access_token.present?

        @access_token = access_token
        @refresh_token = refresh_token
        @client = retrieve_client
      end

      def self.for(provider)
        class_name = provider.to_s.classify
        "External::Provider::#{class_name}".safe_constantize
      end

      # The name of the provider
      def self.name
        :base
      end

      # The user's info
      def info
        handle_unimplmeneted_method
      end

      # The user's credentials
      def credentials
        ProviderCredentials.new do |c|
          c.access_token = access_token
          c.refresh_token = refresh_token
        end
      end

      # The raw info returned from the hash
      def raw_info
        @raw_info ||= retrieve_user_info.deep_symbolize_keys
      end

      # Returns the raw info hash from the client
      def retrieve_user_info
        handle_unimplmeneted_method
      end

      def retrieve_client
        handle_unimplmeneted_method
      end

      private

      def handle_missing_access_token
        raise CustomError.new("missing token", :unprocessable_entity)
      end

      def handle_unimplmeneted_method(method = :method)
        raise CustomError.new("expected super class to override #{method}", :unprocessable_entity)
      end
    end
  end
end
