class AdjustColumnToQpconProducts < ActiveRecord::Migration
  def change
    add_column :qpcon_products, :reg_dtm, :string

    rename_column :qpcon_products, :max_sale, :max_sale_cnt
    rename_column :qpcon_products, :min_sale, :min_sale_cnt
    rename_column :qpcon_products, :max_month_sale, :mon_max_sale_cnt
    rename_column :qpcon_products, :is_sale, :sale_gb
    rename_column :qpcon_products, :product_type, :prod_gb

    remove_column :qpcon_products, :info
  end
end
