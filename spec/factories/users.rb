FactoryBot.define do
  factory :user do
    mobile { "+96655#{7.times.map{rand(10)}.join}" }
    name { Faker::Name.name }
    password { "000000" }
    password_confirmation { "000000" }
    type {['admin', 'normal_user'].sample}
    confirmed_at { DateTime.now }
  end
end
