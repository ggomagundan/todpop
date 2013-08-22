class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :facebook
      t.string :password_digest, :null => false
      t.string :nickname, :unique => true, :null => false
      t.string :recommend
      t.integer :sex
      t.date :birth
      t.string :address
      t.string :mobile, :unique => true, :null => false
      t.datetime :date
      t.datetime :late_connection
      t.integer :level_test

      t.timestamps
    end
  end
end
