class ListShare < ApplicationRecord
  belongs_to :todo_list
  belongs_to :user

  validates :permission_level, presence: true, inclusion: { in: %w[read read_write] }
  validates :user_id, uniqueness: { scope: :todo_list_id }

  after_create_commit :broadcast_share
  after_destroy_commit :broadcast_unshare

  private

  def broadcast_share
    broadcast_replace_to todo_list,
                         target: "share_form_#{todo_list_id}",
                         partial: "list_shares/form",
                         locals: { todo_list: todo_list }
  end

  def broadcast_unshare
    broadcast_replace_to todo_list,
                         target: "share_form_#{todo_list_id}",
                         partial: "list_shares/form",
                         locals: { todo_list: todo_list }
  end
end
