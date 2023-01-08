class NullifyConfirmationTokenJob <  ApplicationJob
  queue_as :default 

  def perform(user_id)
    User.find(user_id).nullify_confirmation_token!
  end
end