class Comment < ApplicationRecord
  belongs_to :post

  validates :body, :author, presence: true

  before_validation :ensure_author_has_a_value

  private
    def ensure_author_has_a_value
        self.author ||= "Guest User"
      end
    end
end
