# frozen_string_literal: true

class AddIndexToColleaguesNameAndEmail < ActiveRecord::Migration[7.0]
  def change
    add_index :colleagues, :name, unique: true
    add_index :colleagues, :email, unique: true
  end
end
