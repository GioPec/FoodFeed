class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.references 'user'
      t.string :title, limit: 100, null: false
      t.string :preparazione, limit: 5000, null: false
      t.string :img, default: "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"
    end
  end
end
