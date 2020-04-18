class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :name
      t.text :description
      t.string :image
      t.date :publish_date
      t.float :price
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
