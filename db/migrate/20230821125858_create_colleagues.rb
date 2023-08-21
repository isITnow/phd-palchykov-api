class CreateColleagues < ActiveRecord::Migration[7.0]
  def change
    create_table :colleagues do |t|
      t.string :name, null: false
      t.string :position
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
