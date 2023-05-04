class User < ApplicationRecord

  validates :project_id, presence: true, length: {in:6..10 }

  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable
end
