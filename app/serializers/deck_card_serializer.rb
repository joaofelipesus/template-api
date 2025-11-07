class DeckCardSerializer
  include JSONAPI::Serializer

  belongs_to :deck, serializer: DeckSerializer
  belongs_to :card, serializer: CardSerializer
end
