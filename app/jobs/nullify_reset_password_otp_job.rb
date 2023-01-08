class NullifyResetPasswordOtpJob <  ApplicationJob
  queue_as :default 

  def perform(user_id)
    User.find(user_id).nullify_reset_password_otp!
  end
end