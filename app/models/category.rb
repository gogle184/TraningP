class Category < ApplicationRecord

  validates :title, presence: true, length: {maximum: 20} ,uniqueness: true
  validates :description, presence: true, length: {maximum: 30},uniqueness: true

  has_many :contents
  belongs_to :admin
end
