module External
  module Provider
    class Facebook < Base
      def info
        ProviderInfo.new do |i|
          i.provider = External::Provider::Facebook.name
          i.date_format = '%m/%d/%Y'
          i.uid = raw_info[:id]
          i.email = raw_info[:email]
          i.birthday = raw_info[:birthday]
          i.first_name = raw_info[:first_name]
          i.last_name = raw_info[:last_name]
          i.name = raw_info[:name]
          i.avatar = raw_info[:picture][:data][:url] rescue nil
        end
      end

      def retrieve_client
        Koala::Facebook::API.new access_token
      end

      def retrieve_user_info
        client.get_object(
          :me,
          fields: %w[id email birthday first_name last_name picture]
        )
      end

      def self.name
        :facebook
      end
    end
  end
end
