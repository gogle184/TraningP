class Admin < ApplicationRecord

  validates :admin_id, presence: true, length: {in:6..10 }, uniqueness: true

  has_many :contents, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :users

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable
end
