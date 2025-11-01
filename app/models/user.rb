class User < ApplicationRecord
  has_secure_password

  attr_accessor :remember_token

  before_validation :normalize_cpf

  validates :name, presence: true
  validates :cpf, presence: true, uniqueness: true, length: { is: 11 }
  validates :password, length: { minimum: 6 }, allow_nil: true

  # Generates a new remember token and stores its digest.
  def remember!
    self.remember_token = SecureRandom.urlsafe_base64(32)
    update!(remember_token_digest: digest_for(remember_token))
  end

  # Clears the remember token digest for logout.
  def forget!
    update!(remember_token_digest: nil)
  end

  # Checks whether a provided token matches the stored digest.
  def authenticated?(token)
    return false if remember_token_digest.blank?

    BCrypt::Password.new(remember_token_digest).is_password?(token)
  end

  private

  def normalize_cpf
    self.cpf = cpf.to_s.gsub(/\D/, "") if cpf_changed?
  end

  def digest_for(token)
    BCrypt::Password.create(token)
  end
end
