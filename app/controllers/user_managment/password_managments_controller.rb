module UserManagment
  class PasswordManagmentsController < ApplicationController
    include PasswordOtpManager
    skip_before_action :authenticate_request!, except: :reset_password


    def forgot_password
      user = User.find_by(mobile: params[:mobile])
      if user && user.set_reset_password_otp
        render json: { :mobile => user.mobile, :reset_password_otp => user.reset_password_otp }, status: :ok
      else
        render json: { :errors => "Phone is incorrect"}, status: :unprocessable_entity
      end
    end

    def verify_otp
      user = User.find_by(mobile: params[:mobile], reset_password_otp: params[:reset_password_otp])
      if user
        render json: { :reset_password_token => password_verification_token(user) }
      else
        render json: { :errors => "OTP code is incorrect"}, status: :unprocessable_entity
      end
    end

    def reset_password
      if @current_user && @current_user.authenticate(params[:old_password])
        render json: { :reset_password_token => password_verification_token(@current_user) }
      else
        render json: { :errors => "Password is incorrect"}, status: :unprocessable_entity
      end
    end

    def set_new_password
      user = User.find(decode_password_otp)
      if user && user.update(set_password_params)
        render json: { :msg => "Password has been updated"}, status: :ok
      else
        render json: {:errors => user.errors}, status: :unprocessable_entity
      end
    end

    private
    def set_password_params
      params.require(:password).permit(:password, :password_confirmation)
    end
  end
end
