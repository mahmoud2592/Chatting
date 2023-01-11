module UserManagment
  class VerificationsController < ApplicationController
    include Phone
    skip_before_action :authenticate_request!

    def confirm_mobile_number
      @user = User.find_by(confirmation_params)
      if @user && @user.confirm!
        @session = create_session_by_id(@user.id)
        render :show, status: :created
      else
        render json: { :error => "Invalid Confirmation Token" }, status: :unprocessable_entity
      end
    end

    def resend_confirmation_token
      @user = User.find_by(mobile: params[:mobile])
      if @user
        # Verifier.send_verification_code(params[:mobile])
        render json: { :message => "Send code to mobile number" }, status: :ok
      else
        render json: { :error => "Invalid mobile number" }, status: :unprocessable_entity
      end
    end

    private

      def confirmation_params
        params.require(:verification).permit(:confirmation_token).merge(id: params[:id])
      end
  end
end
