class CreatePolls < ActiveRecord::Migration[5.0]
  def change
    create_table :polls do |t|
      t.text :topic

      t.timestamps
    end
  end
end
