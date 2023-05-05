class Content < ApplicationRecord

  validates :title, presence: true, length: {in: 4..20}, uniqueness: true
  validates :category_id, presence: true
  validates :description, presence: true, length: {maximum: 30}
  validates :project_id, presence: true
  validate :text_required

  belongs_to :admin
  has_rich_text :text
  belongs_to :category
  mount_uploader :video, VideoUploader
  mount_uploader :image, ActionTextImageUploader

  private
  def text_required 
    errors.add(:text, "は必須項目です") unless text.body.present?
  end
end
