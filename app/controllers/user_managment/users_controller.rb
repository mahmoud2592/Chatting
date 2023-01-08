module UserManagment
  class UsersController < ApplicationController

    skip_before_action :authenticate_request!
    def create
      @user = user_class.new(user_params)
      # authorize [:user_managment, @user]
      if @user.save
        render :show, status: :created
      else
        render json: {:errors => @user.errors}, status: :unprocessable_entity
      end
    end
    
    private

      def user_params
        params.require(params_key).permit(:mobile, :password, :password_confirmation)
      end
  end
end