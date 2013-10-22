class CreateAdvertiseCpdmLogs < ActiveRecord::Migration
  def change
    create_table :advertise_cpdm_logs do |t|
      t.integer :ad_id
      t.integer :ad_type , default:201
      t.integer :user_id
      t.integer :view_time

      t.timestamps
    end
  end
end
