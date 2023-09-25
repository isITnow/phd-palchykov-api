class DropDeviseApiTokens < ActiveRecord::Migration[7.0]
  def change
    drop_table :devise_api_tokens
  end
end
