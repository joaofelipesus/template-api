class User < ApplicationRecord
  has_many :project_users, dependent: :destroy
  has_many :projects, through: :project_users
  has_many :tasks, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end

