class CreateDeckCards < ActiveRecord::Migration[8.1]
  def change
    create_table :deck_cards do |t|
      t.references :card, null: false, foreign_key: true
      t.references :deck, null: false, foreign_key: true

      t.timestamps
    end
  end
end
