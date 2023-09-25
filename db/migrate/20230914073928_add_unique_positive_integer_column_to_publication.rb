class AddUniquePositiveIntegerColumnToPublication < ActiveRecord::Migration[7.0]
  def change
    add_column :publications, :sequence_number, :integer, null: false

    # Add a check constraint to ensure the value is positive
    execute <<-SQL
      ALTER TABLE publications
      ADD CONSTRAINT check_positive_sequence_number
      CHECK (sequence_number > 0);
    SQL

    add_index :publications, :sequence_number, unique: true
  end
end
