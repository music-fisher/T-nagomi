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
  
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  validates :name, presence: true
  validates :introduction, length: { maximum: 200 } 
  attachment :profile_image
  validates :comment_content, presence: true, length: {maximum: 1000}
 
  # フォロー機能
  def follow(user_id)
    relationship = relationships.new(followed_id: user_id)
    relationship.save
  end
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  def following?(user)
    followings.include?(user)
  end
  # def follow(other_user)
  #   unless self == other_user
  #     self.relationships.find_or_create_by(followed_id: other_user.id)
  #   end
  # end
  # def unfollow(other_user)
  #   relationship = self.relationships.find_by(followed_id: other_user.id)
  #   relationship.destroy if relationship
  # end
  # def following?(other_user)
  #   self.followings.include?(other_user)
  # end
end
