class AddUpdateCounttoAboutMe < ActiveRecord::Migration[5.0]
  def change
  	add_column :about_mes, :update_count, :integer, default: 0
  end
end
