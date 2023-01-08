module UserManagment
  class SessionsController < ApplicationController
    
    skip_before_action :authenticate_request!

    def create
      @session = create_session(session_params[:mobile], session_params[:password])
        render :show, status: :created
    end

    private

      def session_params
        params.require(:session).permit(:mobile, :password)
      end
  end
end