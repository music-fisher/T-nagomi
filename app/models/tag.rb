class Tag < ApplicationRecord
  has_many :tagmaps, dependent: :destroy
  has_many :posts, through: :tagmaps
  validates :tag_name, presence: true,length:{maxmum:50}
end
