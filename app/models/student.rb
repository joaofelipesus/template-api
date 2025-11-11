class Student < ApplicationRecord
  validates :name, :age, presence: true
end
