class Admin < ApplicationRecord

  validates :project_id, presence: true, length: {in:6..10 }, uniqueness: true

  has_many :contents, dependent: :destroy
  has_many :categories, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

  def self.guest
    find_or_create_by!(email: 'guest_admin@example.com') do |admin|
      admin.password = ENV['GUEST_ADMIN_PASSWORD']
      admin.password_confirmation = ENV['GUEST_ADMIN_PASSWORD']
      admin.project_id = ENV['GUEST_PROID']
    end
  end
end
