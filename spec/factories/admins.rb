FactoryBot.define do
  factory :admin do
    email { 'example@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
    project_id { '111111'}
  end
end
