require "active_support/concern"
require Rails.root.join('lib/Chat_exception')
require Rails.root.join('lib/jwt_manager')

module HeaderBasedSessionManager
  extend ActiveSupport::Concern


  def create_session(mobile, password)
    user  = User.find_by(mobile: mobile)
    if user && user.authenticate(password)
      session_data(user)
    elsif user && !user.authenticate(password)
      raise ChatException::InvalidPassword
    else
      raise ChatException::InvalidCredentials
    end
  end


  def create_session!(mobile, password)
    user  = User.find_by(mobile: mobile)
    if user && user.authenticate(password)
      session_data(user)
    else
      raise ChatException::InvalidCredentials
    end
  end

  def create_session_by_id(id)
    user  = User.find(id)
    session_data(user)
  end

  def create_session_by_object(user)
    session_data(user)
  end

  def session_data(user)
    if user
      data = {
          access_token: JWTManager.encode({user_id: user.id}),
          user: user
      }
      return OpenStruct.new data
    end
  end

  def authenticate_request!
    raise ChatException::MissingToken unless http_access_token_header
    raise ChatException::UnAuthenticated unless is_authenticated_request?
    raise ChatException::UnConfirmedUser unless current_user.confirmed?
  end

  def is_authenticated_request?
    !!current_user
  end

  def user_id
    user_id ||= http_access_token_header.present? ? JWTManager.decode(http_access_token_header)["user_id"] : nil
  end

  def current_user
    @current_user ||= User.find(user_id) if user_id
  end

  def http_access_token_header
    request.headers['X-access-token']
  end

end
