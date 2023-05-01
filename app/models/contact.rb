class Contact < ApplicationRecord

  validates :name, presence: true, length: {maximum: 10}
  validates :email, presence: true
  validates :content, presence: true, length: {maximum: 100}
end
