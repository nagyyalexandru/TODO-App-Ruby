class User < ApplicationRecord
  acts_as_authentic do |c|
    c.crypto_provider = ::Authlogic::CryptoProviders::SCrypt
  end

  attr_accessor :password_confirmation

  validate :passwords_match

  private

  def passwords_match
    if password.present? && password_confirmation.present? && password != password_confirmation
      errors.add(:password_confirmation, "doesn't match Password")
    end
  end
end
