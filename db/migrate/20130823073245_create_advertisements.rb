class CreateAdvertisements < ActiveRecord::Migration
  def change
    create_table :advertisements do |t|
      t.integer :kind
      t.string :content1
      t.string :content2
      t.integer :count
      t.integer :remain
      t.string :local, :default => ""
      t.integer :interest, :default => 0
      t.integer :sexual, :default => 0
      t.integer :facebook, :defulat => 0
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
