class User < ApplicationRecord

  validates :admin_id, presence: true, length: {in:6..10 }

  has_many :contents
  has_many :categories
  belongs_to :user

  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable
end
