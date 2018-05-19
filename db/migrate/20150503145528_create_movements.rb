class CreateMovements < ActiveRecord::Migration[4.2]
  def change
    create_table :movements do |t|
      t.string :description
      t.date :date
      t.decimal :amount
      t.references :account, index: true, foreign_key: true
      t.references :budget, index: true, foreign_key: true
      t.references :period, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
