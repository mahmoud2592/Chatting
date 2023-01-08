module UserManagment
  class VerificationsController < ApplicationController
    
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
      
    end

    private

      def confirmation_params
        params.require(:verification).permit(:confirmation_token).merge(id: params[:id])
      end
  end
end
