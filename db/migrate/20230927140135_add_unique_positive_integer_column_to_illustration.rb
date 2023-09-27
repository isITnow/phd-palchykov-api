class AddUniquePositiveIntegerColumnToIllustration < ActiveRecord::Migration[7.0]
  def change
    add_column :illustrations, :sequence_number, :integer, null: false

    # Add a check constraint to ensure the value is positive
    execute <<-SQL
      ALTER TABLE illustrations
      ADD CONSTRAINT check_positive_sequence_number
      CHECK (sequence_number > 0);
    SQL
  end
end
