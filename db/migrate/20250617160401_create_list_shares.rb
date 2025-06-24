class CreateListShares < ActiveRecord::Migration[7.2]
  def change
    create_table :list_shares do |t|
      t.references :todo_list, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :permission_level

      t.timestamps
    end
  end
end
