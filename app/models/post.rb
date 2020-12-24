class Post < ApplicationRecord
  belongs_to :user
  attachment :post_image
  enum kind: {抹茶: 0,玉露: 1, 煎茶: 2,番茶: 3, その他: 4}
end
