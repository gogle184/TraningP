class Category < ApplicationRecord
  validates :title, presence: true, length: { maximum: 20 }, uniqueness: { scope: :admin_id }
  validates :description, presence: true, length: { maximum: 30 }, uniqueness: { scope: :admin_id }
  has_many :contents, dependent: :destroy
  belongs_to :admin
end
