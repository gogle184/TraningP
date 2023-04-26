class Content < ApplicationRecord
  belongs_to :user
  has_rich_text :text
  belongs_to :category
end
