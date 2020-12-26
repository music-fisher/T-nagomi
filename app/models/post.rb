class Post < ApplicationRecord
  belongs_to :user
  attachment :post_image
  enum kind: {抹茶: 0,玉露: 1, 煎茶: 2,番茶: 3, その他: 4}
  has_many :tagmaps, dependent: :destroy
  has_many :tags, through: :tagmaps
  
  def save_post(savepost_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - savepost_tags
    new_tags = savepost_tags - current_tags
    # 古いタグの削除
    old_tags.each do |old_name|
      self.tags.delete Tags.find_by(tag_name :old_name)
    end
    # 新しいタグの保存
    new_tags.each do |new_name|
      post_tag = Tag.find_by_or_create(tag_name :new_name)
      self.tags << post_tag
    end
  end
end
