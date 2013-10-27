class CreateInactiveUsers < ActiveRecord::Migration
  def change
    create_table :inactive_users do |t|
      t.string :email
      t.string :facebook
      t.string :password_digest
      t.string :nickname
      t.string :recommend
      t.integer :sex
      t.date :birth
      t.string :address
      t.string :mobile
      t.integer :interest
      t.integer :level_test
      t.integer :is_set_facebook_password
      t.integer :attendance_time
      t.integer :current_reward
      t.integer :total_reward
      t.integer :is_admin
      t.datetime :last_connection

      t.timestamps
    end
  end
end
