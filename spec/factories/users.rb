FactoryBot.define do
  factory :user do
    sequence(:email) {|n| 'user_#{n}@example.com'}  
    password { 'password' }
    password_confirmation { 'password' }
    project_id { FactoryBot.generate(:admin).project_id }
    reset_password_token { "reset_password_token_#{SecureRandom.hex}" }
  end
end
