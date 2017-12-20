class CreateForecasts < ActiveRecord::Migration[4.2]
  def change
    create_table :forecasts do |t|
      t.references :period, index: true, foreign_key: true
      t.references :budget, index: true, foreign_key: true
      t.decimal :amount

      t.timestamps null: false
    end
  end
end
