class AdjustColumnTypeQpconCategoryId < ActiveRecord::Migration
  def change
    change_column :qpcon_products, :qpcon_category_id, :string
  end
end
