class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :crypted_password, null: false
      t.string :password_salt, null: false

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
