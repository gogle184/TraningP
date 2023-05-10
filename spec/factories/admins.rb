FactoryBot.define do
  factory :admin do
    sequence(:email) {|n| "admin_#{n}@example.com"}
    password { 'password' }
    password_confirmation { 'password' }
    sequence(:project_id) {|n| 'testT#{n}'} 
  end
end
