class AddAuthlogicFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    change_table :users, bulk: true do |t|
      t.string :crypted_password unless column_exists?(:users, :crypted_password)
      t.string :password_salt unless column_exists?(:users, :password_salt)
      t.string :persistence_token unless column_exists?(:users, :persistence_token)
      t.string :single_access_token unless column_exists?(:users, :single_access_token)
      t.string :perishable_token unless column_exists?(:users, :perishable_token)
      t.integer :login_count, default: 0, null: false unless column_exists?(:users, :login_count)
      t.integer :failed_login_count, default: 0, null: false unless column_exists?(:users, :failed_login_count)
      t.datetime :last_request_at unless column_exists?(:users, :last_request_at)
      t.datetime :current_login_at unless column_exists?(:users, :current_login_at)
      t.datetime :last_login_at unless column_exists?(:users, :last_login_at)
      t.string :current_login_ip unless column_exists?(:users, :current_login_ip)
      t.string :last_login_ip unless column_exists?(:users, :last_login_ip)
    end
  end
end
