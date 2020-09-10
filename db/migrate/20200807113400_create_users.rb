class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string  :username, limit: 20, unique: true, default: ' '
      t.string  :first_name, limit: 20, default: ' '
      t.string  :last_name, limit: 20, default: ' '
      t.date    :date_of_birth
      t.integer :phone_number, unique: true, default: ' '
      t.integer :gender, default: '0'
      t.string  :email, limit: 50, unique: true, default: ' '
      t.string  :bio, limit: 500, default: ' '
      t.string  :img, default: "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"
      t.string  :role, default: "U"
      t.timestamps
    end
  end
end
