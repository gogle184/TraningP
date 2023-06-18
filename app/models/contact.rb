class Contact < ApplicationRecord
  validates :name, presence: true, length: { maximum: 10 }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :content, presence: true, length: { maximum: 300 }
end
