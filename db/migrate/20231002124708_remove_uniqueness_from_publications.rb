# frozen_string_literal: true

class RemoveUniquenessFromPublications < ActiveRecord::Migration[7.0]
  def change
    remove_index :publications, :sequence_number
  end
end
