class CreateAdvertiseLogs < ActiveRecord::Migration
  def change
    create_table :advertise_logs do |t|
      t.integer :advertisement_id, :references => :advertisements
      t.integer :user_id, :references => :users
      t.integer :view_time

      t.timestamps
    end
  end
end
