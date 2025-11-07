class DeckCard < ApplicationRecord
  belongs_to :card
  belongs_to :deck

  validates :card_id, presence: true
  validates :deck_id, presence: true
end
