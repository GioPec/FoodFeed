class AddCategoriesToRecipes < ActiveRecord::Migration[6.0]
  def change
    add_column :recipes, :category, :string, default: ''
    add_column :recipes, :course, :string, default: ''
  end
end
