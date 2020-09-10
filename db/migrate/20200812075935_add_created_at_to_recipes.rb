class AddCreatedAtToRecipes < ActiveRecord::Migration[6.0]
  def change
    add_column :recipes, :created_at, :datetime
  end
end
