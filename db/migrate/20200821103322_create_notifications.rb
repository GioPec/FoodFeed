class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.references 'user'
      t.references 'recipe'
      t.references 'sender'
      t.string :type
      t.boolean :read, default: false
      t.timestamps
    end
  end
end
