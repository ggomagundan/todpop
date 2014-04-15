class CreateAdvertiseLockLogs < ActiveRecord::Migration
  def change
    create_table :advertise_lock_logs do |t|
      t.integer :ad_id
      t.integer :ad_type
      t.integer :user_id
      t.integer :act

      t.timestamps
    end
  end
end
