class Belt < ApplicationRecord
  has_many :graduations, dependent: :destroy
  has_many :presences, foreign_key: :current_belt_id, dependent: :destroy

  validates :name, :presences_required, presence: true
  validates :name, uniqueness: true

  def self.white
    find_by!(name: "White")
  end

  def black?
    name == "Black"
  end

  def next
    raise "Black belt is the last graduation" if black?

    Belt.where(sequence_index: sequence_index + 1)
  end
end
