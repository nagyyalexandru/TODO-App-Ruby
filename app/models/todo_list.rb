class TodoList < ApplicationRecord
  belongs_to :user
  has_many :tasks, -> { order(position: :asc) }, dependent: :destroy
  has_many :list_shares, dependent: :destroy
  has_many :shared_users, through: :list_shares, source: :user

  validates :title, presence: true

  # For sharing functionality
  def shared_with?(user)
    shared_users.include?(user)
  end

  def permission_for(user)
    list_shares.find_by(user: user)&.permission_level
  end
end