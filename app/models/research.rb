# frozen_string_literal: true

class Research < ApplicationRecord
  has_many :illustrations, -> { order(sequence_number: :asc) }, dependent: :destroy
end
