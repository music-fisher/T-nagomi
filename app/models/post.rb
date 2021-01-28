class Post < ApplicationRecord
  belongs_to :user
  has_many :tagmaps, dependent: :destroy
  has_many :tags, through: :tagmaps
  has_many :bookmarks,dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :notifications, dependent: :destroy

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
      self.tags.delete Tag.find_by(tag_name: old_name)
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
  # 通知機能
  def create_notification_by(current_user)
    notification = current_user.active_notifications.new(
      post_id: id,
      visited_id: user_id,
      action: "like"
      )
      notification.save if notification.valid?
  end
  def create_notification_comment!(current_user, comment_id)
    # 自分以外にコメントを送った人に対して全て通知を送る
    temp_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user,comment_id,temp_id['user_id'])
    end
    # 誰もコメントしてないときは、投稿者に通知を送る
      save_notification_comment!(current_user,comment_id,user_id) if temp_ids.blank?
  end
  def save_notification_comment(current_user,comment_id,visited_id)
    current_user.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
      )
    # 自分に対してのコメントであれば通知すみにする
    if notification.visiter_id == notification.visited_id
        notification.checked = true
    end
    notification.save if notification.valid?
  end
end
