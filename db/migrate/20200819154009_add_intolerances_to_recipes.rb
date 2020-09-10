class AddIntolerancesToRecipes < ActiveRecord::Migration[6.0]
  def change
    add_column :recipes, :intolerance, :string, default: ''
    add_column :recipes, :price, :integer, default: 1
    add_column :recipes, :difficulty, :integer, default: 1
    add_column :recipes, :time, :integer, default: 0
  end
end