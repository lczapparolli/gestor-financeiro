class AddUserReferences < ActiveRecord::Migration[4.2]
  def up
    change_table :accounts do |t|
      t.references :user, index: true, foreign_key: true
    end

    change_table :periods do |t|
      t.references :user, index: true, foreign_key: true
    end

    change_table :budgets do |t|
      t.references :user, index: true, foreign_key: true
    end

    change_table :movements do |t|
      t.references :user, index: true, foreign_key: true
    end

    change_table :forecasts do |t|
      t.references :user, index: true, foreign_key: true
    end
  end

  def down
    remove_foreign_key :accounts, :users
    remove_foreign_key :periods, :users
    remove_foreign_key :budgets, :users
    remove_foreign_key :movements, :users
    remove_foreign_key :forecasts, :users

    change_table :accounts do |t|
      t.remove :user_id
    end

    change_table :periods do |t|
      t.remove :user_id
    end

    change_table :budgets do |t|
      t.remove :user_id
    end

    change_table :movements do |t|
      t.remove :user_id
    end

    change_table :forecasts do |t|
      t.remove :user_id
    end
  end
end
