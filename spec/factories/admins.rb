FactoryBot.define do
  factory :admin do
    sequence(:email) { |n| "admin_#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
    sequence(:project_id) { |_n| 'testT#{n}' }
    admin { true }
  end
end
