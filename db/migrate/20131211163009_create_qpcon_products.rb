class CreateQpconProducts < ActiveRecord::Migration
  def change
    create_table :qpcon_products do |t|
      t.string :product_id
      t.integer :qpcon_category_id
      t.string :product_name
      t.string :change_market_name
      t.integer :stock_count
      t.integer :market_cost
      t.integer :common_cost
      t.string :img_url_70
      t.string :img_url_150
      t.string :img_url_250
      t.string :market_name
      t.integer :min_age
      t.text :use_info
      t.integer :valid_type
      t.string :valid_date
      t.integer :max_sale
      t.integer :min_sale
      t.integer :max_month_sale
      t.integer :is_sale
      t.integer :pin_type
      t.integer :product_type

      t.timestamps
    end
  end
end
