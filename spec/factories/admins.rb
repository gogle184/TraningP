FactoryBot.define do
  factory :admin do
    sequence(:email) { |n| 'example#{n}@example.com'}
    password { 'password' }
    password_confirmation { 'password' }
    sequence(:project_id) { |n| 'test#{n}'}
  end
end
