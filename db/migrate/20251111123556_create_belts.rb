class CreateBelts < ActiveRecord::Migration[8.1]
  def change
    create_table :belts do |t|
      t.string :name
      t.integer :presences_required

      t.timestamps
    end
  end
end
