# frozen_string_literal: true

module Validatable
  extend ActiveSupport::Concern

  included do
    validates :sequence_number, presence: true, numericality: { only_integer: true, greater_than: 0 }
  end
end
