class CreateGraduations < ActiveRecord::Migration[8.1]
  def change
    create_table :graduations do |t|
      t.belongs_to :student, null: false, foreign_key: true
      t.references :belt, null: false, foreign_key: true

      t.timestamps
    end
  end
end
