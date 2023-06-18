class User < ApplicationRecord
  validates :project_id, presence: true, length: { in: 6..10 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.guest
    find_or_create_by!(email: 'guest_user@example.com') do |user|
      user.password = ENV['GUEST_USER_PASSWORD']
      user.password_confirmation = ENV['GUEST_USER_PASSWORD']
      user.project_id = ENV['GUEST_PROID']
    end
  end
end
