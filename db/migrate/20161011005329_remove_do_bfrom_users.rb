class RemoveDoBfromUsers < ActiveRecord::Migration[5.0]
  def change
  	remove_column :users, :date_of_birth, :string
  end
end
