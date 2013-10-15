class CreateCpdAds < ActiveRecord::Migration
  def change
    create_table :cpd_ads do |t|
      t.integer :cpd_kind
      t.string :front_image
      t.string :back_image
      t.integer :coupon_id
      t.integer :priority, :default => 4

      t.timestamps
    end
  end
end
