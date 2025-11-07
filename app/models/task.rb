class Task < ApplicationRecord
  belongs_to :project
  belongs_to :user

  validates :category, presence: true
end

