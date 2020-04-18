class CreateAuthors < ActiveRecord::Migration[5.2]
  def change
    create_table :authors do |t|
      t.string :name
      t.date :brith_year
      t.string :phone
      t.string :address

      t.timestamps
    end
  end
end
