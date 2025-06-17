class Task < ApplicationRecord
  belongs_to :todo_list

  validates :title, presence: true
  validates :completed, inclusion: { in: [true, false] }

  after_create_commit -> { broadcast_append_to todo_list }
  after_update_commit -> { broadcast_replace_to todo_list }
  after_destroy_commit -> { broadcast_remove_to todo_list }
end