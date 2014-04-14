class AddAuthorIdToReviewsTable < ActiveRecord::Migration
  def change
    add_column :reviews, :author_id, :integer
    remove_column :reviews, :user_id, :integer
  end
end
