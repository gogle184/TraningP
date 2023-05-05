FactoryBot.define do
  factory :contact do
    email { 'example@example.com' }
    name { '佐藤' }
    content { 'テストですよ' }
  end
end
