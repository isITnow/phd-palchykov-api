# frozen_string_literal: true

class AddYearToPublication < ActiveRecord::Migration[7.0]
  def change
    add_column :publications, :year, :string, null: false
  end
end
