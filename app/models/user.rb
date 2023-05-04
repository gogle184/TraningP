class User < ApplicationRecord

  validates :admin_id, presence: true, length: {in:6..10 }

  belongs_to :admin
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable
end
