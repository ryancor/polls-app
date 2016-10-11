class AddIsPublicToUsers < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :is_public, :boolean, default: true
  end
end
