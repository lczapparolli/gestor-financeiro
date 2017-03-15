class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :auth_token
      t.string :first_name, null: true
      t.string :last_name, null: true

      t.timestamps null: false
    end
  end
end
