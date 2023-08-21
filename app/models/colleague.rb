class Colleague < ApplicationRecord
  validates :name, :position, presence: true
end
