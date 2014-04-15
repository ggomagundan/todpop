class CreateLockAdvertisements < ActiveRecord::Migration
  def change
    create_table :lock_advertisements do |t|
      t.string :ad_name
      t.integer :cli_id, :default => 1
      t.integer :ad_type
      t.integer :contract, :default => 0
      t.integer :remain, :default => 0
      t.integer :basic_show_price, :default => 0
      t.integer :action_price, :default => 0
      t.integer :reward, :default => 0
      t.integer :point, :default => 0
      t.integer :pay_type, :default => 1
      t.string :target_url
      t.string :ad_image
      t.date :start_date
      t.date :end_date
      t.integer :priority, :default => 4

      t.timestamps
    end
  end
end
