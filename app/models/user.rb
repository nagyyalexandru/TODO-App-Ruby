class User < ApplicationRecord
  acts_as_authentic do |c|
    c.crypto_provider = ::Authlogic::CryptoProviders::SCrypt
  end

  attr_accessor :password_confirmation

  has_many :todo_lists, dependent: :destroy
  has_many :list_shares, dependent: :destroy
  has_many :shared_todo_lists, through: :list_shares, source: :todo_list

  validate :passwords_match

  def accessible_todo_lists
    TodoList.where(id: todo_lists.pluck(:id) + shared_todo_lists.pluck(:id))
  end

  private

  def passwords_match
    if password.present? && password_confirmation.present? && password != password_confirmation
      errors.add(:password_confirmation, "doesn't match Password")
    end
  end
end