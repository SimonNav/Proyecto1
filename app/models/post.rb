class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  validates :user_id, presence: true
  validates :image, presence: true
  validates :description, presence: true, length: { minimum: 10 }
end
