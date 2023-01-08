Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  scope module: 'user_managment' do
    %w[farmers brokers merchants admins service_providers].each do |user_type|
      post "#{user_type}/register", to: "#{user_type}#create"
      post "#{user_type}/:id/confirm_mobile_number", to: 'verifications#confirm_mobile_number'
      post "#{user_type}/:id/resend_confirmation_token", to: 'verifications#resend_confirmation_token'
    end
    post '/reset_password', to: 'password_managments#reset_password'
    post 'forgot_password', to: 'password_managments#forgot_password'
    post 'verify_otp', to: 'password_managments#verify_otp'
    post '/set_password', to: 'password_managments#set_new_password'
    resources :sessions, only: [:create]
    get '/myprofile', to: 'profiles#show'
    patch '/myprofile', to: 'profiles#update'
  end
end
