class News < ApplicationRecord
  include AttachedImageValidation

  before_validation :ensure_date_has_a_value

  has_one_attached :image

  validates :body, length: { minimum: 10 }, allow_nil: true
  validates :date, presence: true
  validates :title, presence: true, length: { minimum: 5, maximum: 150 }

  validate do
    validate_attached_image image, 1
  end

  private

  def ensure_date_has_a_value
    return unless date.nil? || date.blank?

    self.date = Time.zone.now.strftime('%B %e, %Y')
  end
end
