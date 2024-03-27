# frozen_string_literal: true

class ChangeColleaguesPhoneAndEmailToNull < ActiveRecord::Migration[7.0]
  def change
    change_column_null :colleagues, :phone, true
    change_column_null :colleagues, :email, true
  end
end
