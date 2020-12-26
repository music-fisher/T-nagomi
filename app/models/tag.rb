class Tag < ApplicationRecord
  has_many :tagmaps, dependent: :destroy
  has_many :posts, through: :tagmaps
  validates :tag_name, presence: true,length:{maximum:50}
end
