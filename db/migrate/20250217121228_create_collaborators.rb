class CreateCollaborators < ActiveRecord::Migration[7.0]
  def change
    create_table :collaborators do |t|
      t.string :name, null: false
      t.string :position, null: false
      t.string :link
      t.integer :category, null: false, default: 0

      t.timestamps
    end

    add_index :collaborators, :name, unique: true
    add_index :collaborators, :link, unique: true
    add_index :collaborators, :category
  end
end
