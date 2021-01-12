FactoryBot.define do
  factory :post do
    title {'テストを書く'}
    body {'RSpec&Capybara&FactoryBotを準備する'}
    user
  end
end