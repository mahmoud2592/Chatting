FactoryBot.define do
  factory :admin, parent: :user do
    type { "Admin" }
  end
end
