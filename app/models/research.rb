class Research < ApplicationRecord
  has_many :illustrations, dependent: :destroy
end

