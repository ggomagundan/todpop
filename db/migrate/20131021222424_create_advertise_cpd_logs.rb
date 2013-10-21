class CreateAdvertiseCpdLogs < ActiveRecord::Migration
  def change
    create_table :advertise_cpd_logs do |t|
      t.integer :ad_id
      t.integer :ad_type
      t.integer :user_id
      t.integer :action

      t.timestamps
    end
  end
end
