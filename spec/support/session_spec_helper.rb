module SessionSpecHelper
  include HeaderBasedSessionManager

  def policies_login_as(user_typ) 
    usr = nil
    if user_typ.is_a? Symbol
      usr ||= FactoryBot.create user_typ
    else 
      usr = user_typ
    end
    let(:user) { usr }
  end 

  def session_headers(user)
    return {} if user.nil?
    return {
      'X-access-token':  create_session_by_object(user).access_token
    }
  end
end
