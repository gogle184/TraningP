FactoryBot.define do
  factory :user do
    sequence(:email) { |_n| 'user_#{n}@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
    project_id { 'testtest' }
  end
end
