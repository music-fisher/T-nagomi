class Post < ApplicationRecord
  belongs_to :user
  has_many :tagmaps, dependent: :destroy
  has_many :tags, through: :tagmaps
  has_many :bookmarks,dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  
  attachment :post_image
  enum kind: {抹茶: 0,玉露: 1, 煎茶: 2,番茶: 3, その他: 4}
  # バリデーション
  validates :title, presence: true,length: { maximum: 20 } 
  validates :body, presence: true,length: { maximum: 800 } 


  def save_post(savepost_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - savepost_tags
    new_tags = savepost_tags - current_tags
    # 古いタグの削除
    old_tags.each do |old_name|
      self.tags.delete Tags.find_by(tag_name: old_name)
    end
    # 新しいタグの保存
    new_tags.each do |new_name|
      post_tag = Tag.find_or_create_by(tag_name: new_name)
      self.tags << post_tag
    end
  end
  
  # current_userに投稿がブックマークされているか確認
  def bookmark_by?(user)
    bookmarks.where(user_id: user.id).exists?
  end
  # 引数で渡されたuserがいいねされてるかどうか確認
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
end
