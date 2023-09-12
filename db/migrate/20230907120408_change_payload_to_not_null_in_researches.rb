class ChangePayloadToNotNullInResearches < ActiveRecord::Migration[7.0]
  def change
    change_column_null :researches, :payload, false
  end
end
