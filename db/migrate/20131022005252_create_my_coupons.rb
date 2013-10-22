class CreateMyCoupons < ActiveRecord::Migration
  def change
    create_table :my_coupons do |t|
      t.integer :user_id
      t.integer :coupon_type
      t.integer :coupon_id
      t.integer :availability,	default: 1

      t.timestamps
    end
  end
end
