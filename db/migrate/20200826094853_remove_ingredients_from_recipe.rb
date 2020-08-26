class RemoveIngredientsFromRecipe < ActiveRecord::Migration[6.0]
  def change
    remove_column :recipes, :ingredients
    add_column :recipes, :ingredients, :string, null: false, default: " "
    change_column :recipes, :ingredients, :string, default: nil
  end
end
