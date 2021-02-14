FactoryBot.define do
  factory :user do
    name {'テストユーザー'}
    sequence(:email) { |n| "test#{n}@example.com" }
    # email { 'test1@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
    introduction {''}
  end
end