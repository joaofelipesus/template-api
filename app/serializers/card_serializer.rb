class CardSerializer
  include JSONAPI::Serializer

  attributes :name, :mana_cost, :cmc, :type_line, :oracle_text,
             :power, :toughness, :colors, :color_identity, :rarity,
             :set_name, :set, :collector_number, :artist, :released_at,
             :scryfall_uri, :card_category
end
