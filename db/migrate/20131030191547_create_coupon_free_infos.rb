class CreateCouponFreeInfos < ActiveRecord::Migration
  def change
    create_table :coupon_free_infos do |t|
      t.string :name
      t.string :place
      t.date :valid_start
      t.date :valid_end
      t.string :bar_code
      t.string :image
      t.text :information

      t.timestamps
    end
  end
end
