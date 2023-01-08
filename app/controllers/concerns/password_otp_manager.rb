require "active_support/concern"
# require Rails.root.join('lib/Chat_exception')
require Rails.root.join('lib/jwt_manager')

module PasswordOtpManager
  extend ActiveSupport::Concern
      # Here to generate a token for verifying password change
      def password_verification_token(user)
        token = JWTManager.encode({user_id: user.id, user_mobile: user.mobile})
      end

      def decode_password_otp
        JWTManager.decode(params[:password][:password_verification_otp])['user_id']
      end
end
