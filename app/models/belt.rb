class Belt < ApplicationRecord
  has_many :graduations, dependent: :destroy
  has_many :presences, foreign_key: :current_belt_id, dependent: :destroy

  validates :name, :presences_required, presence: true
  validates :name, uniqueness: true
end
