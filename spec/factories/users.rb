FactoryBot.define do
  factory :sato, class: User do
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 8) }
    password_confirmation { password }
    admin { true }
    admin_id { 11111111 }
  end

  factory :suzuki, class: User do
    email { Faker::Internet.free_email }
    password { Faker::Internet.password(min_length: 8) }
    password_confirmation { password }
    admin { false }
    admin_id { 99999999 }
  end
end
