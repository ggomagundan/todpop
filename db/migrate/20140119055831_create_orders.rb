class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.string :order_id
      t.string :barcode
      t.string :product_id
      t.string :qpcon_order_id
      t.boolean :is_used, :default => false
      t.date :limit_date

      t.timestamps
    end
  end
end
