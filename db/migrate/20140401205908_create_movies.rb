class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title, null: false
      t.string :year, null: false
      t.string :superhero, null: false
      t.string :mpaa_rating
      t.text :synopsis
      t.string :director

      t.timestamps

    end

    add_index :movies, [:title, :year], unique: true
  end
end
