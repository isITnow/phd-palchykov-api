# frozen_string_literal: true

class CreatePublicationPeriods < ActiveRecord::Migration[7.0]
  def change
    create_table :publication_periods do |t|
      t.string :title, null: false

      t.timestamps
    end
  end
end
