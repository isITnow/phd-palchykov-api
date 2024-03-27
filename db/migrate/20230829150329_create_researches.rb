# frozen_string_literal: true

class CreateResearches < ActiveRecord::Migration[7.0]
  def change
    create_table :researches do |t|
      t.jsonb :payload

      t.timestamps
    end
  end
end
