class Belt < ApplicationRecord
  validates :name, :presences_required, presence: true
  validates :name, uniqueness: true
end
