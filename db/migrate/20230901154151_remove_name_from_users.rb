# frozen_string_literal: true

class RemoveNameFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :name
  end
end
