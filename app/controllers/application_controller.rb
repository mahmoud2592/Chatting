class ApplicationController < ActionController::API
  helper ApiHelper
  include Responseable
  include ActAsApiRequest
  include HeaderBasedSessionManager
  include Pundit::Authorization
  before_action :authenticate_request!


  # rescue_from Pundit::NotAuthorizedError, with: :un_authorized
  # rescue_from ChatException::MissingToken, with: :un_authinticated
  # rescue_from ChatException::InvalidPassword, with: :invalid_password
  # rescue_from ChatException::InvalidCredentials, with: :invalid_mobile
  helper_method :current_user


  # def un_authorized
  #   render json:{errors:{auth_error:"Not authorized to perform this action"}}, status: 401
  # end

  # def invalid_password
  #   render json:{errors:{password:"Password is incorrect"}}, status: 401
  # end

  # def invalid_mobile
  #   render json:{errors:{mobile:"Mobile is incorrect"}}, status: 401
  # end

  # def un_authinticated
  #   render json: 'Missing or expired token', status: 403
  # end

  protected

  def ensure_json_request
    request.format = :json
  end

  def set_response_metadata
    @response_metadata = {}
  end
end
