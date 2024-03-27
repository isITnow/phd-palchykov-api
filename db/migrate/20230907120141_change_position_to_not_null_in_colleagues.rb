# frozen_string_literal: true

class ChangePositionToNotNullInColleagues < ActiveRecord::Migration[7.0]
  def change
    change_column_null :colleagues, :position, false
  end
end
