class CreateCpdmAdvertisements < ActiveRecord::Migration
  def self.up
    create_table :cpdm_advertisements do |t|
      t.integer :kind, :default => 1
      t.date :start_time
      t.date :end_time
      t.integer :count
      t.integer :remain
      t.integer :priority, :default => 4
      t.string :url
      t.timestamps
    end
  end

  def self.down
    drop_table :cpdm_advertisements
  end
end
