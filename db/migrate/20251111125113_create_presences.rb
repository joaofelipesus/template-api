class CreatePresences < ActiveRecord::Migration[8.1]
  def change
    create_table :presences do |t|
      t.belongs_to :student, null: false, foreign_key: true
      t.references :current_belt, null: false, foreign_key: true

      t.timestamps
    end
  end
end
