class Content < ApplicationRecord
  belongs_to :user
  has_rich_text :text
  belongs_to :category
  mount_uploader :video, VideoUploader
  mount_uploader :image, ActionTextImageUploader
end
