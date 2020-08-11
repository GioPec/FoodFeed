class AddLikesToRecipes < ActiveRecord::Migration[6.0]
  def change
    add_column :recipes, :likes, :integer, default: 0
  end
end
