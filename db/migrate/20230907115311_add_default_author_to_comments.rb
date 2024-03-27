class AddDefaultAuthorToComments < ActiveRecord::Migration[7.0]
  def change
    change_column_default :comments, :author, 'Guest User'
  end
end
