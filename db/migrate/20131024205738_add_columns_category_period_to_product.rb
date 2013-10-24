class AddColumnsCategoryPeriodToProduct < ActiveRecord::Migration
  def change
    add_column :products, :category, :integer
    add_column :products, :period, :integer
  end
end
