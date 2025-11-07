class Card < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  has_many :deck_cards, dependent: :destroy
  has_many :decks, through: :deck_cards

  validates :name, presence: true

  # Elasticsearch index settings and mappings
  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :name, type: :text, analyzer: :english
      indexes :mana_cost, type: :keyword
      indexes :cmc, type: :float
      indexes :type_line, type: :text, analyzer: :english
      indexes :oracle_text, type: :text, analyzer: :english
      indexes :power, type: :keyword
      indexes :toughness, type: :keyword
      indexes :colors, type: :keyword
      indexes :color_identity, type: :keyword
      indexes :rarity, type: :keyword
      indexes :set_name, type: :text
      indexes :set, type: :keyword
      indexes :collector_number, type: :keyword
      indexes :artist, type: :text
      indexes :released_at, type: :date
      indexes :scryfall_uri, type: :keyword
      indexes :card_category, type: :keyword
    end
  end

  # Define how the document should be indexed
  def as_indexed_json(options = {})
    as_json(
      only: [
        :id, :name, :mana_cost, :cmc, :type_line, :oracle_text,
        :power, :toughness, :colors, :color_identity, :rarity,
        :set_name, :set, :collector_number, :artist, :released_at,
        :scryfall_uri, :card_category
      ]
    )
  end
end
