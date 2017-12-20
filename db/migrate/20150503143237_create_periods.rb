class CreatePeriods < ActiveRecord::Migration[4.2]
  def change
    create_table :periods do |t|
      t.string :name
      t.date :start
      t.date :end

      t.timestamps null: false
    end
  end
end
