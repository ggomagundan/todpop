class CreateCpxAdvertisements < ActiveRecord::Migration
  def self.up
    create_table :cpx_advertisements do |t|
      t.integer :kind
      t.date :start_time
      t.date :end_time
      t.integer :count
      t.integer :remain
      t.integer :priority, :default => 5
      t.string :url
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :cpx_advertisements
  end
end
