class CreateTasks < ActiveRecord::Migration[7.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.boolean :completed
      t.text :notes
      t.references :todo_list, null: false, foreign_key: true
      t.integer :position

      t.timestamps
    end
  end
end
