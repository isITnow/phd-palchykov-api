class AddDefaultToNewsDate < ActiveRecord::Migration[7.0]
  def change
    change_column_default :news, :date, from: nil, to: ''
  end
end
