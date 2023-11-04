class News < ApplicationRecord
  before_validation :ensure_date_has_a_value

  validates :body, length: { minimum: 10 }
  validates :date, presence: true
  validates :title, presence: true, length: { minimum: 5, maximum: 150 }
  
  has_one_attached :image

  private

  def ensure_date_has_a_value
    if self.date.nil? || self.date.blank?
      self.date = Time.zone.now.strftime('%B %e, %Y')
    end
  end
end

