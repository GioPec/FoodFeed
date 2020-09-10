class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.references 'user'
      t.references 'recipe'
      t.datetime :created_at
      t.string :body
    end
  end
end
