FactoryBot.define do
  factory :user do
    email { 'gogle184@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
    project_id { 'testtest' }
    reset_password_token { "reset_password_token_#{SecureRandom.hex}" }
  end
end
