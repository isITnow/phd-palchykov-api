# frozen_string_literal: true

class CreatePublications < ActiveRecord::Migration[7.0]
  def change
    create_table :publications do |t|
      t.string :title, null: false
      t.string :source, null: false
      t.string :source_url, null: false
      t.string :authors, array: true, default: []
      t.belongs_to :publication_period, null: false, foreign_key: true

      t.timestamps
    end
  end
end
