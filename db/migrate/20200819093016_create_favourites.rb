class CreateFavourites < ActiveRecord::Migration[6.0]
  def change
    create_table :favourites do |t|
      t.references 'user'
      t.references 'recipe'
    end
  end
end
