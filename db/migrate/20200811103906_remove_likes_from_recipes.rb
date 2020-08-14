class RemoveLikesFromRecipes < ActiveRecord::Migration[6.0]
  def change
    remove_column :recipes, :likes
    add_column :recipes, :n_likes, :integer
    add_column :recipes, :n_comments, :integer
  end
end
