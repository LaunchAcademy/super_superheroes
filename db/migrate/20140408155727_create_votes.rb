class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :user_id, null: false
      t.integer :movie_id, null: false
      t.string :value, null: false

      t.timestamps
    end
  end
end
