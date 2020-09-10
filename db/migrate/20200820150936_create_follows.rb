class CreateFollows < ActiveRecord::Migration[6.0]
  def change
    create_table :follows do |t|
      t.references 'follower'
      t.references 'following'  
    end
  end
end
