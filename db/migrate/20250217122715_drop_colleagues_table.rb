class DropColleaguesTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :colleagues
  end
end
