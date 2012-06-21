class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_hash
      t.string :password_salt
      t.string :login
      t.string :name
      t.string :lastname
      t.has_attached_file :avatar
      t.date :byrthday
      t.integer:phone_number
      t.timestamps
    end
  end
end
