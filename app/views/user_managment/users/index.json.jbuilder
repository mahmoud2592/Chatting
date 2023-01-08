json.array! @users do |user|
  json.partial! "user_managment/users/user", user: user
end