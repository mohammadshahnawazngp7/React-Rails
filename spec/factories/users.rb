FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email } # Generates unique email each time
    password { 'password' }
    password_confirmation { 'password' }
  end
end
