class Project < ApplicationRecord
  belongs_to :company
  has_many :project_users, dependent: :destroy
  has_many :users, through: :project_users
  has_many :tasks, dependent: :destroy

  validates :name, presence: true
end

