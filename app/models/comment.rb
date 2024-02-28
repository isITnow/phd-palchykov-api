class Comment < ApplicationRecord
  include AttachedImageValidation
  
  belongs_to :post
  has_one_attached :comment_image

  before_validation :ensure_author_has_a_value
  
  validates :author, presence: true
  validates :body, presence: true, length: { minimum: 5, maximum: 700 }

  validate do
    validate_attached_image comment_image, 1
  end
  
  
  private
  def ensure_author_has_a_value
    if self.author.nil? || self.author.blank?
      self.author = "Guest User"
    end
  end
end
