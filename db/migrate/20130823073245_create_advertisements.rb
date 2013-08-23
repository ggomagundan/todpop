class CreateAdvertisements < ActiveRecord::Migration
  def change
    create_table :advertisements do |t|
      t.integer :kind
      t.string :content1
      t.string :content2
      t.string :type, :default => ""
      t.integer :count
      t.integer :remain
      t.string :local, :default => ""
      t.string :interest, :default => ""
      t.integer :sexual, :default => 0
      t.integer :facebook, :defulat => 0
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
