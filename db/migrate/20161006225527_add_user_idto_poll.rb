class AddUserIdtoPoll < ActiveRecord::Migration[5.0]
  def change
  	add_column :polls, :user_id, :integer, foreign_key: true
  end
end
