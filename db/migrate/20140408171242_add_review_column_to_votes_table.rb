class AddReviewColumnToVotesTable < ActiveRecord::Migration
  def change
    add_column :votes, :review_id, :integer
    remove_column :votes, :movie_id, :integer
  end
end
