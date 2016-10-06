class CreateVoteOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :vote_options do |t|
      t.string :title
      t.references :poll, foreign_key: true

      t.timestamps
    end
  end
end
