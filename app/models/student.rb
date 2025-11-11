class Student < ApplicationRecord
  has_many :presences, dependent: :destroy
  has_many :graduations, dependent: :destroy

  validates :name, :age, presence: true
end
