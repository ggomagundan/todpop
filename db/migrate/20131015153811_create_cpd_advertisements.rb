class CreateCpdAdvertisements < ActiveRecord::Migration
  def change
    create_table :cpd_advertisements do |t|
      t.integer :kind
      t.integer :count
      t.integer :remain
      t.datetime :start_time
      t.datetime :end_time
      t.string :front_image
      t.string :back_image
      t.integer :coupon_id

      t.timestamps
    end
  end
end
