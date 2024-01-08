class Colleague < ApplicationRecord
  has_one_attached :photo
  
  validates :email, uniqueness: { allow_nil: true }, allow_nil: true
  validates :name, presence: true, length: { minimum: 5 }, uniqueness: true
  validates :photo, presence: true
  validates :position, presence: true, length: { minimum: 5 }
end

