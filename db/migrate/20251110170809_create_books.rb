class CreateBooks < ActiveRecord::Migration[8.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :subtitle
      t.text :description
      t.integer :pages
      t.string :isbn

      t.timestamps
    end
  end
end
