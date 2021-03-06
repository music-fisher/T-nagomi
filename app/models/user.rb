class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_posts, through: :bookmarks, source: :post
  # フォロー機能
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :relationships,class_name: "Relationship",foreign_key: "follower_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower
  has_many :followings, through: :relationships, source: :followed
  # 通知機能
  has_many :active_notifications, class_name: "Notification", foreign_key: "visiter_id",dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id",dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :liked_posts, through: :likes, source: :post

  validates :name, presence: true
  validates :introduction, length: { maximum: 200 }
  attachment :profile_image

  # フォロー機能
  def follow(user_id)
    relationship = relationships.new(followed_id: user_id.id)
    relationship.save
  end
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  def following?(user)
    followings.include?(user)
  end
  # ゲストログイン
  def self.guest
    find_or_create_by(name: 'ゲストユーザー', email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end
  # フォロー通知機能
  def create_notification_follow!(current_user)
    # すでに通知されているか確認
    temp = Notification.where("visiter_id = ? and visited_id = ? and action = ?",current_user.id,id,'follow')
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
        )
      notification.save if notification.valid?
    end
  end

end
