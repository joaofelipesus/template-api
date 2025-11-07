class CreateCards < ActiveRecord::Migration[8.1]
  def change
    create_table :cards do |t|
      t.string :name
      t.string :mana_cost
      t.decimal :cmc
      t.string :type_line
      t.text :oracle_text
      t.string :power
      t.string :toughness
      t.string :colors
      t.string :color_identity
      t.string :rarity
      t.string :set_name
      t.string :set
      t.string :collector_number
      t.string :artist
      t.date :released_at
      t.string :scryfall_uri
      t.string :card_category

      t.timestamps
    end
  end
end
