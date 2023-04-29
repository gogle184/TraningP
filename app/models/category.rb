class Category < ApplicationRecord

  validates :title, presence: true, length: {maximum: 20}, uniqueness: true
  validates :description, presence: true, length: {maximum: 30}

  has_many :contents
  belongs_to :user
end
