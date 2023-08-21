class CreateNews < ActiveRecord::Migration[7.0]
  def change
    create_table :news do |t|
      t.string :title, null: false
      t.text :body
      t.string :date
      t.string :links, array: true, default: []

      t.timestamps
    end
  end
end
