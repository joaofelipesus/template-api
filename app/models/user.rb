class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  has_many :user_books
  has_many :books, through: :user_books

  def self.jwt_revoked?(payload, user)
    # Implement revocation logic if needed
    false
  end

  def self.revoke_jwt(payload, user)
    # Implement revocation logic if needed
  end
end
