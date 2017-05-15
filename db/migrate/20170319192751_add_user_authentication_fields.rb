class AddUserAuthenticationFields < ActiveRecord::Migration
  def up
    change_table :users do |t|
      t.remove :auth_token
      t.string :email
      t.string :password_digest
      t.string :session_hash
      t.string :session_salt
      t.date :last_login
    end
  end

  def down
    change_table :users do |t|
      t.string :auth_token
      t.remove :email
      t.remove :password_digest
      t.remove :session_hash
      t.remove :session_salt
      t.remove :last_login
    end
  end
end
