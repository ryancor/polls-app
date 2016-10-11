class AddAgeToAboutMe < ActiveRecord::Migration[5.0]
  def change
  	add_column :about_mes, :age, :integer
  end
end
