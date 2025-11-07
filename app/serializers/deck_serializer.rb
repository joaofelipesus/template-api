class DeckSerializer
  include JSONAPI::Serializer

  attributes :name

  attribute :cards_count do |deck|
    deck.cards.count
  end

  has_many :cards, serializer: CardSerializer
end
