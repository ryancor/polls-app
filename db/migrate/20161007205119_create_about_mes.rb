class CreateAboutMes < ActiveRecord::Migration[5.0]
  def change
    create_table :about_mes do |t|
      t.string :bio
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
