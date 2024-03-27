# frozen_string_literal: true

class CreateIllustrations < ActiveRecord::Migration[7.0]
  def change
    create_table :illustrations do |t|
      t.text :description, null: false
      t.belongs_to :research, null: false, foreign_key: true

      t.timestamps
    end
  end
end
