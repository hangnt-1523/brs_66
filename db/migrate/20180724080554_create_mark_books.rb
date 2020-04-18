class CreateMarkBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :mark_books do |t|
      t.integer :status
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true

      t.timestamps
    end
  end
end
