class RemoveLikesFromRecipes < ActiveRecord::Migration[6.0]
  def change
    remove_column :recipes, :likes
    add_column :recipes, :likes, :integer
  end
end
